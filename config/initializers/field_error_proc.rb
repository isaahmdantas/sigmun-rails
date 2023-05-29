ActionView::Base.field_error_proc = Proc.new { |html_tag, instance|
  if html_tag.include?("label")
    html_tag.html_safe
  else
    attribute_id = !html_tag.slice(/id=.[a-zA-Z0-9_-]*/).nil? ? html_tag.slice(/id=.[a-zA-Z0-9_-]*/).gsub(/id=\"/,"") : html_tag.slice(/name=.[^""]*/).gsub(/name=\"/,"") .gsub("[]", "").gsub("[", "_").gsub("]", "")
    if html_tag[html_tag.rindex('[')+1, (html_tag.rindex(']') - html_tag.rindex('[')-1)].to_sym == :""
      attribute_name = attribute_id.gsub(instance.object.class.name.downcase + "_", "").to_sym
    else 
      attribute_name = html_tag[html_tag.rindex('[')+1, (html_tag.rindex(']') - html_tag.rindex('[')-1)].to_sym 
    end

    error_message = instance.object.errors.full_messages_for(attribute_name)
    if error_message.kind_of?(Array)
      error_message = error_message.uniq.join(', ')
    end
    %(#{html_tag}<div id='invalid-feedback-#{attribute_id}'' class='invalid-feedback'>#{error_message}</div><script>$('#invalid-feedback-#{attribute_id}').closest('td').addClass("novalidate");$('#invalid-feedback-#{attribute_id}').closest('.mb-3').find('label').addClass('label-required');$('#invalid-feedback-#{attribute_id}').closest('.mb-3').find('input').addClass('is-invalid');$('#invalid-feedback-#{attribute_id}').closest('.mb-3').find('textarea').addClass('is-invalid');$('#invalid-feedback-#{attribute_id}').closest('.mb-3').find('span.select2').addClass('is-invalid');$('#invalid-feedback-#{attribute_id}').closest('.mb-3').addClass('novalidate');$('div#invalid-feedback-#{attribute_id}').not(":last").remove();</script>).html_safe
  end
}