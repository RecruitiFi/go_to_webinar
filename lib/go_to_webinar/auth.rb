require 'oauth2'
require_relative 'auth/client'
require_relative 'auth/configuration'

module GoToWebinar
  class Auth
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
