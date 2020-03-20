require 'oauth2/client'
require 'oauth2/configuration'

module GoToWebinar
  class OAuth2
    class << self
      attr_accessor :client, :configuration

      def client
        @client ||= GoToWebinar::OAuth2::Client.new
      end

      def configuration
        @configuration ||= GoToWebinar::OAuth2::Configuration.new
      end

      def setup
        yield(configuration)
        @client = nil
      end
    end
  end
end
