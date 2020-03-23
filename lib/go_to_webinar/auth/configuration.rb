# frozen_string_literal: true

module GoToWebinar
  module Auth
    class Configuration
      attr_accessor :redis_url, :consumer_key, :secret_key, :site
      attr_accessor :authorize_url, :token_url, :auth_scheme
      attr_accessor :basic_auth_username, :basic_auth_password
      attr_accessor :authorize_optional_params

      def initialize
        @site = self.class.site
        @authorize_url = self.class.authorize_url
        @authorize_optional_params = self.class.authorize_optional_params
        @token_url = self.class.token_url
        @auth_scheme = self.class.auth_scheme
      end

      def self.site
        'https://api.getgo.com'
      end

      def self.authorize_url
        '/oauth/v2/authorize'
      end

      def self.authorize_optional_params
        { response_type: 'code' }
      end

      def self.token_url
        '/oauth/v2/token'
      end

      def self.auth_scheme
        'basic_auth'
      end
    end
  end
end
