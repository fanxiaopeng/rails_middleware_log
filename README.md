# RailsMiddlewareLog

Print Log for request when every middleware start.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rails_middleware_log'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rails_middleware_log

## log

```ruby
Started GET "/path/of/request" for ::1 at 2016-02-17 10:48:55 +0800
-------ActionDispatch::ShowExceptions
-------WebConsole::Middleware
-------ActionDispatch::DebugExceptions
-------ActionDispatch::RemoteIp
-------ActionDispatch::Reloader
-------ActionDispatch::Callbacks
-------ActiveRecord::Migration::CheckPending
  ActiveRecord::SchemaMigration Load (23.0ms)  SELECT "schema_migrations".* FROM "schema_migrations"
-------ActiveRecord::ConnectionAdapters::ConnectionManagement
-------ActionDispatch::Cookies
-------ActionDispatch::Session::CookieStore
-------ActionDispatch::Flash
-------ActionDispatch::ParamsParser
-------Rack::Head
-------Rack::ConditionalGet
-------Rack::ETag
-------Rack::Head

```

## Usage

blank

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

1. Fork it ( https://github.com/[my-github-username]/rails_middleware_log/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
