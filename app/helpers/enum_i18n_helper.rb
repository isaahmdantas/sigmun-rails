

module EnumI18nHelper
  # Returns an array of the possible key/i18n values for the enum
  # Example usage:
  # enum_options_for_select(Usuario, :apsimuladol_state)
  def enum_options_for_select(class_name, enum)
    class_name.send(enum.to_s.pluralize).map do |key, _|
      [enum_i18n(class_name, enum, key), key]
    end
  end

  def enum_options_for_select_value(class_name, enum)
    class_name.send(enum.to_s.pluralize).map do |key, value|
      [enum_i18n(class_name, enum, key), value]
    end
  end

  # Returns the i18n version the the models current enum key
  # Example usage:
  # enum_l(user, :apsimuladol_state)
  def enum_l(model, enum)
    enum_i18n(model.class, enum, model.send(enum))
  end

  # Returns the i18n string for the enum key
  # Example usage:
  # enum_i18n(Usuario, :apsimuladol_state, :unprocessed)
  def enum_i18n(class_name, enum, key)
    I18n.t("activerecord.attributes.#{class_name.model_name.i18n_key}.#{enum.to_s.pluralize}.#{key}")
  end

  def array_enum_options_for_select(class_name, enum)
    class_name.send(enum).map do |key, _|
      [I18n.t("activerecord.attributes.#{class_name.model_name.i18n_key}.array_enum.#{enum}.#{key}"), key]
    end
  end

  def array_enum_i18n(model, enum)
    model.send(enum).map do |key, _|
      I18n.t("activerecord.attributes.#{model.class.model_name.i18n_key}.array_enum.#{enum}.#{key}")
    end
  end

  def classes_options_for_select(klass)
    Rails.application.eager_load!
    begin
      object_space = ObjectSpace.each_object(Class).select { |c| c.ancestors.include? klass }
      objects = object_space.nil? ? [] : object_space
      objects.map do |key, _|
        [I18n.t("activerecord.models.#{key.model_name.i18n_key}.one"), key]
      end
    rescue StandardError
    end
  end
end
