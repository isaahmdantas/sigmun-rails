# Limita o número de requisições por IP
Rack::Attack.throttle('req/ip', limit: 300, period: 5.minutes) do |req|
    req.ip
end
  

Rack::Attack.blocklist('fail2ban pentesters') do |req|
    # `filter` returns truthy value if request fails, or if it's from a previously banned IP
    # so the request is blocked
    Rack::Attack::Fail2Ban.filter("pentesters-#{req.ip}", maxretry: 3, findtime: 10.minutes, bantime: 5.minutes) do
        # The count for the IP is incremented if the return value is truthy
        CGI.unescape(req.query_string) =~ %r{/etc/passwd} ||
        req.path.include?('/etc/passwd') ||
        req.path.include?('wp-admin') ||
        req.path.include?('wp-login')

    end
end
  
VIOLATIONS = ['../../../../../../../../../../etc/services']
Rack::Attack.blocklist('blocklist/violations') do |req|
    # Bloqueia solicitações que contenham essa sequência de caracteres na URL
    VIOLATIONS.include?(req.path)
end

Rack::Attack.blocklist('block PRI requests') do |req|
    req.request_method == 'PRI'
end

Rack::Attack.blocklisted_responder = lambda do |env|
  # Personalize a resposta de bloqueio de acordo com suas necessidades
  [403, {}, ['Blocked']]
end