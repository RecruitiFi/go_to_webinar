require 'oauth2'
require 'redis'

module GoToWebinar
  module Auth
    class Client
      attr_accessor :basic_auth_username, :basic_auth_password, :consumer_key, :secret_key
      
      def initialize(basic_auth_username:, basic_auth_password:, consumer_key:, secret_key:)
        config = GoToWebinar::Auth.configuration
        @redis = Redis.new(url: config.redis_url)
        @basic_auth_username = basic_auth_username || config.basic_auth_username
        @basic_auth_password = basic_auth_password || config.basic_auth_password
        @consumer_key = consumer_key || config.consumer_key
        @secret_key = secret_key || config.secret_key
        @site = config.site
        @authorize_url = config.authorize_url
        @token_url = config.token_url
        @auth_scheme = config.auth_scheme
        @oauth2_client = new_oauth2_client
      end

      def new_oauth2_client
        oauth2_client = OAuth2::Client.new(
          consumer_key,
          secret_key,
          site: site,
          authorize_url: authorize_url,
          token_url: token_url,
          auth_scheme: auth_scheme
        )
      end

      def access_token
        @access_token || get_access_token_from_redis || get_new_access_token
      end

      def get_new_access_token
        token = oauth2_client.password.get_token(basic_auth_username, basic_auth_password)
        save_to_redis(token)
        @access_token = token
      end

      def refresh_access_token
        @access_token = access_token&.refresh!
      end

      private

      attr_accessor :redis, :site, :authorize_url, :authorize_url_optional_params
      attr_accessor :token_url, :auth_scheme, :oauth2_client

      def get_access_token_from_redis(redis_key: 'g2w_access_token')
        # retrieve from redis
        token_json = @redis.get(redis_key)
        token_hash = JSON.parse(token_json)&.[]("token") if token_json
        @access_token = OAuth2::AccessToken.from_hash(oauth2_client, token_hash) if token_hash

        # if we found it redis, let's return it
        return @access_token if @access_token

        # if it doesn't currently exist in redis, return nil
        nil
      end

      def save_to_redis(token, redis_key: 'g2w_access_token')
        @redis.set(redis_key, token.to_hash.to_json)
      end

      def oauth2_client
        OAuth2::Client.new(
          consumer_key,
          secret_key,
          site: site,
          authorize_url: authorize_url,
          token_url: token_url,
          auth_scheme: auth_scheme
        )
      end

      def authorize_url
        authorize_url + '?' + authorize_url_params
      end

      def authorize_url_params
        URI.encode_www_form({client_id: consumer_key}.merge(authorize_url_optional_params))
      end
    end
  end
end
