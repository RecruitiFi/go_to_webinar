module GoToWebinar
  class Client
    attr_accessor :url, :organizer_key, :access_token

    def initialize(organizer_key: nil, url: nil)
      config = GoToWebinar.configuration
      @url = url || config.url
      @organizer_key = organizer_key || config.organizer_key
      @g2w_oauth2_client = GoToWebinar::OAuth2::Client.new
      @access_token = @g2w_oauth2_client.access_token&.token || config.access_token
    end

    def headers
      {
        'Accept' => 'application/json',
        'Authorization' => "OAuth oauth_token=#{access_token}"
      }
    end

    def get(path, data = {})
      attempt { parse(RestClient.get(make_path(path), data.merge(headers))) }
    end

    def post(path, data)
      attempt { parse(RestClient.post(make_path(path), data, headers)) }
    end

    def put(path, data)
      attempt { parse(RestClient.put(make_path(path), data, headers)) }
    end

    def delete
      attempt { parse(RestClient.delete(make_path(path), data, headers)) }
    end

    def make_path(path)
      path.gsub!(':organizer_key:', organizer_key)
      "#{url}#{path}"
    end

    private

    def attempt
      begin
        retries ||= 0
        yield
      rescue RestClient::Forbidden => exception
        raise unless (retires += 1) < 2
        raise unless int_error_code(exception) == "InvalidToken"
        raise unless @access_token&.expired?

        @access_token = @g2w_oauth2_client.refresh_access_token.token
        retry
      end
    end

    def int_error_code(exception)
      JSON.parse(exception&.http_body)&.[]("int_err_code")
    end

    def parse(response)
      JSON.parse(response.body)
    end
  end
end
