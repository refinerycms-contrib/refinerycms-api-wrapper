# Refinery CMS API Wrapper

[![Build Status](https://travis-ci.org/refinerycms-contrib/refinerycms-api-wrapper.svg?branch=master)](https://travis-ci.org/refinerycms-contrib/refinerycms-api-wrapper)

A Ruby library for working with the The Refinery CMS REST API.


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'refinerycms-api-wrapper'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install refinerycms-api-wrapper

## Usage

Configure a connection to the API:

```ruby
Refinery::API.configure do |conf|
  conf.api_token = "123"
  conf.api_url = "http://localhost:3000"
  conf.api_path = "/api/v1"
end
```

Make your first call:

```ruby
client = Refinery::API::Pages.new
pages = client.index.body
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/refinerycms-api-wrapper.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

