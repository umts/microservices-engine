require 'net/http'
config_file = '../mse_router_info.yml'
puts("[MSE] > No router configuration YAML file found") and return if
  not File.file?(config_file)

config_data = YAML.read(config_file)
router_uri = 'http://example.com/' # TODO: Add the correct router endpoint
res = Net::HTTP.post_form(router_uri,
                    'ph_name' => config_data['service_name'],
                    'ph_models' => config_data['accessible_models'])

# Placeholders stuff below
puts res.body # PH

# Probably don't need this if the router will just send data to the endpoint
# (not in a response, right?). Actually, that'd be way easier if I don't
# have to handle the response.
if res.code == 200 and res.message == "OK"
  # We did it!
else
  # We suck
end
