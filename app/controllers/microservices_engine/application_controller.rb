# frozen_string_literal: true
module MicroservicesEngine
  # This is a comment to make rubocop go away
  class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception
  end
end
