# RailsMiddlewareLog

Print Log for request when every middleware start in Rails. You can set which request to log, and the content you want to print.

在Rails的每个middleware开始的时候打印日志，可以配置那些请求，以及自定义打印内容。

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
add the following example code to application.rb
```ruby
    RailsMiddlewareLog.configure do |config|
      config.target_urls = ['/coupon/v1/coupon_batches']
      config.before_middleware = ->(middleware_class, env) do
        puts middleware_class
      end
    end
```

1. target_urls： select target request url to log. default: log nothing 
    - Boolean
    true will log every request
    - String
    equal to PATH_INFO
    - Array
    contains PATH_INFO
    - Regexp
    match PATH_INFO
2. before_middleware：a lambda with two args, for user to custom.
    - middleware_class
    class of current middleware
    - env
    one arg of middleware call method


## Development

After checking out the repo, run `bin/setup` to install dependencies. 

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

1. Fork it ( https://github.com/[my-github-username]/rails_middleware_log/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
