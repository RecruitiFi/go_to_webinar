# frozen_string_literal: true

require 'rest-client'
require 'json'
require 'go_to_webinar/attendee'
require 'go_to_webinar/client'
require 'go_to_webinar/configuration'
require 'go_to_webinar/auth'
require 'go_to_webinar/registrant'
require 'go_to_webinar/session'
require 'go_to_webinar/version'
require 'go_to_webinar/webinar'

module GoToWebinar
  @client ||= GoToWebinar::Client.new
  @configuration ||= GoToWebinar::Configuration.new

  class << self
    attr_accessor :client, :configuration

    def setup
      yield(configuration)
      @client = nil
    end
  end
end
