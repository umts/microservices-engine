# frozen_string_literal: true
require 'net/http'
CONFIG_FILE = 'config/mse_router_info.yml'

unless ENV['DISABLE_ROUTER_CHECKIN']

  report_missing_config_key = lambda do |key|
    raise ArgumentError, "Missing key #{key} in #{CONFIG_FILE}"
  end

  unless File.file?(CONFIG_FILE)
    raise IOError, 'No router configuration YAML file found'
  end

  config_data = YAML.load_file(CONFIG_FILE)

  service_name = config_data.fetch 'name', &report_missing_config_key
  service_url = config_data.fetch 'uri', &report_missing_config_key
  router_url = config_data.fetch 'router_uri', &report_missing_config_key
  security_token = config_data.fetch 'security_token', &report_missing_config_key

  router_url = router_url + '/services/register'

  res = Net::HTTP.post_form(
    URI.parse(router_url),
    name: service_name,
    url: service_url,
    models: config_data['accessible_models'],
    security_token: security_token
  )

  raise 'The router API response was invalid' if res.code != '200'

end
