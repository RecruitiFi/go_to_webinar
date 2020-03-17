# GoToWebinar

A ruby client to connect GoToWebinar API.

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
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

The repository maintainer only intends to add the functionality necessary for the maintainers need, this will not include all functionality or support all API of GoToWebinar. If you would like to contribute, pull requests are welcome.
 
Bug reports and pull requests are welcome on GitHub at https://github.com/RecruitiFi/go_to_webinar.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
