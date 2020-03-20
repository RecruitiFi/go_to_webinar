module GoToWebinar
  module Auth
    class Configuration
      attr_accessor :redis_url, :consumer_key, :secret_key, :site
      attr_accessor :authorize_url, :token_url, :auth_scheme
      attr_accessor :basic_auth_username, :basic_auth_password
      attr_accessor :authorize_optional_params

      def initialize
        @site = GoToWebinar::Auth::Configuration.site
        @authorize_url = GoToWebinar::Auth::Configuration.authorize_url
        @authorize_optional_params = GoToWebinar::Auth::Configuration.authorize_optional_params
        @token_url = GoToWebinar::Auth::Configuration.token_url
        @auth_scheme = GoToWebinar::Auth::Configuration.auth_scheme
      end

      def self.site
        'https://api.getgo.com'
      end

      def self.authorize_url
        '/oauth/v2/authorize'
      end

      def self.authorize_optional_params
        { response_type: "code" }
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
