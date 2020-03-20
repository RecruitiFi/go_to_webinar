# GoToWebinar

A ruby client to connect GoToWebinar API V1. Will handle the complete OAuth lifecycle as well utilizing Redis and the OAuth2 gems.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'go_to_webinar'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install go_to_webinar

## Usage

### Rails

config/initializers/go_to_webinar.rb
```ruby
GoToWebinar.setup do |g2w|
  g2w.organizer_key = ENV['G2W_ORGANIZER_KEY']
  g2w.access_token = ENV['G2W_ACCESS_TOKEN']
end

GoToWebinar::Auth.setup do |oauth2|
  oauth2.redis_url = ENV['REDISCLOUD_URL']
  oauth2.consumer_key = ENV['G2W_CONSUMER_KEY']
  oauth2.secret_key = ENV['G2W_SECRET_KEY']
  oauth2.basic_auth_username = ENV['G2W_BASIC_AUTH_USERNAME']
  oauth2.basic_auth_password = ENV['G2W_BASIC_AUTH_PASSWORD']
end
```

## Authentication Strategy

This gem will use your username and password to handle all OAuth authentication with GoToWebinar using a basic auth strategy. This does require use of the GoToWebinar log in credentials. It is advised you fully read and understand the different OAuth Flows and use the best one for your situation: https://auth0.com/docs/api-auth/which-oauth-flow-to-use

## Contributing

The repository maintainer only intends to add the functionality necessary for the maintainers need, this may not include all functionality or support all API of GoToWebinar. If you would like to contribute, pull requests are welcome.
 
Bug reports and pull requests are welcome on GitHub at https://github.com/RecruitiFi/go_to_webinar.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
