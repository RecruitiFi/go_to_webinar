require 'rest-client'
require 'json'
require_relative 'go_to_webinar/attendee'
require_relative 'go_to_webinar/client'
require_relative 'go_to_webinar/configuration'
require_relative 'go_to_webinar/auth'
require_relative 'go_to_webinar/registrant'
require_relative 'go_to_webinar/session'
require_relative 'go_to_webinar/version'
require_relative 'go_to_webinar/webinar'

module GoToWebinar
  class << self
    attr_accessor :client, :configuration

    def client
      @client ||= GoToWebinar::Client.new
    end

    def configuration
      @configuration ||= Configuration.new
    end

    def setup
      yield(configuration)
      @client = nil
    end
  end
end
