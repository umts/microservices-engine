# frozen_string_literal: true
require 'net/http'
config_file = 'config/mse_router_info.yml'

REPORT_MISSING_CONFIG_KEY = -> (key) {
  raise ArgumentError, "Missing key #{key} in #{config_file}"
}

unless File.file?(config_file)
  raise IOError, 'No router configuration YAML file found'
end

config_data = YAML.load_file(config_file)

service_name = config_data.fetch 'name', &REPORT_MISSING_CONFIG_KEY
service_url = config_data.fetch 'uri', &REPORT_MISSING_CONFIG_KEY
router_url = config_data.fetch 'router_uri', &REPORT_MISSING_CONFIG_KEY
security_token = config_data.fetch 'security_token', &REPORT_MISSING_CONFIG_KEY
router_url = router_url + '/services/register'

res = Net::HTTP.post_form(
  URI.parse(router_url),
  name: service_name,
  url: service_url,
  models: config_data['accessible_models'],
  security_token: security_token
)

raise 'The router API response was invalid' if res.code != '200'
