# UMTS MicroservicesEngine for Rails 3
## If you are using a rails 3 app, use this branch for your gem version.
### A note for Engine developers:
remember to delete your Gemfile.lock, rvm use 1.9.3, and then bundle to start development on this branch. The workflow should be: merge from Master, run rspec,
fix anything that breaks. Do not develop new functionality on this branch, just pull from Master whenever there are any changes to it.

[![Build Status](https://travis-ci.org/umts/microservices-engine.svg?branch=master)](https://travis-ci.org/umts/microservices-engine)
[![Test Coverage](https://codeclimate.com/github/umts/microservices-engine/badges/coverage.svg)](https://codeclimate.com/github/umts/microservices-engine/coverage)
[![Code Climate](https://codeclimate.com/github/umts/microservices-engine/badges/gpa.svg)](https://codeclimate.com/github/umts/microservices-engine)
[![Issue Count](https://codeclimate.com/github/umts/microservices-engine/badges/issue_count.svg)](https://codeclimate.com/github/umts/microservices-engine)

## About

This is a gem / engine designed to provide simplistic inter-service communication between various UMTS (UMass Transportation Services) microservices. Not designed to be used in an independent environment outside of the UMTS office, but you are welcome to try.
### Rails version supported:
Rails 3

## Setup

### Require the gem

In your Gemfile, add the following line to source from the correct branch:

```ruby
gem 'umts-microservices-engine', require: microservices_engine, git: 'https://github.com/umts/microservices-engine.git', branch: 'rails3-version'
```

### Installing the gem

Once you add the gem to your Gemfile, you need to run this command in the directory of your Rails app

```ruby
rails generate install microservices-engine
```
This will generate the files, `config/mse_router_info.yml` and `config/initializers/microservices_engine.rb`. It will also add a migration to your migrations folder
to generate the necessary table. Don't forget to run migrations after. It will also add a line to your gitignore so config/mse_router_info.yml is not version-controlled.

### Setting up the configuration

You need not worry about `config/initializers/microservices_engine.rb`, however you must edit `config/mse_router_info.yml` or your application will now fail to launch as the initializer requires data from this file.

```yml
# UMass Transit Microservices Engine
# Router API Data Endpoint Configuration

# REQUIRED field
# The name of the microservice
name: ''

# REQUIRED field
# The URI for the site hosting the microservice
# NOTE: Do not attach the /v1/data to this.
uri: ''

# REQUIRED field
# Verification token
security_token: ''

# REQUIRED Field
# Endpoint of Microservices router
router_uri: ''

# OPTIONAL field (leave blank if not applicable)
# The models that the service can give info on
accessible_models: []
```

 * The `name` of your application can be anything you desire.
 * The `uri` is the base link for the website this is being hosted on. For example, `http://potatoes.com/`. Do NOT attach the router's respective endpoint to this link. So do **NOT** do this: `http://potatoes.com/v1/data/`.
 * The `security_token` is a local token that should be set to something extremely confidential. To change this, you must contact the administrator of the `microservices-router` portion so that they can modify your token. Once the token is set, there is no way to change it. Attempting to change it will cause an exception during setup.
 * The `router_uri` is just the endpoint that the engine will send data to. Contact the router's administrator to find out this value.
 * The `accessible_models` field is optional. In here you will put a list of strings corresponding to the "models" you want other engines to be able to access. **This assumes you have an API endpoint / documentation for these models on your application**.
 
### Finish

You should now be able to run your server. If anything goes wrong, the console should alert you.
To run your server without checking in with the router, run 
```ruby
$ DISABLE_ROUTER_CHECKIN=true rails server 
```
