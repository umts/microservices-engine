# frozen_string_literal: true
require 'net/http'
config_file = 'config/mse_router_info.yml'

unless File.file?(config_file)
  raise IOError, '[MSE] > No router configuration YAML file found'
end

config_data = YAML.load_file(config_file)

if [config_data['name'], config_data['uri'], config_data['security_token']].any?(&:blank?)
  raise '[MSE] > Please fill out config/mse_router_info.yml'
end

router_uri = URI::HTTP.build(host: config_data['router_uri'])
res = Net::HTTP.post_form(
  router_uri,
  'name': config_data['name'],
  'url': uri,
  'models': config_data['accessible_models'],
  'security_token': config_data['security_token']
)

raise '[MSE] > The router API response was invalid' if res.code != '200'
