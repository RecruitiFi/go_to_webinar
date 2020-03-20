require 'oauth2'
require 'go_to_webinar/auth/client'
require 'go_to_webinar/auth/configuration'

module GoToWebinar
  module Auth
    class << self
      attr_accessor :client, :configuration

      def client
        @client ||= GoToWebinar::Auth::Client.new
      end

      def configuration
        @configuration ||= GoToWebinar::Auth::Configuration.new
      end

      def setup
        yield(configuration)
        @client = nil
      end
    end
  end
end
