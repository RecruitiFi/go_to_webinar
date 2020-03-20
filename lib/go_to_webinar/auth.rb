require 'oauth2'
require 'auth/client'
require 'auth/configuration'

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
