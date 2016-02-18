require 'rails_middleware_log/version'

module RailsMiddlewareLog
end

# load Rails/Railtie
begin
  require 'rails'
rescue LoadError
  # do nothing
end

$stderr.puts <<-EOC if !defined?(Rails)
warning: no framework detected.

Your Gemfile might not be configured properly.
---- e.g. ----
Rails:
    gem 'rails_middleware_log'

EOC

# load components
require 'rails_middleware_log/config'
require 'rails_middleware_log/hooks'
require 'rails_middleware_log/log'

# if not using Railtie, call `RailsMiddlewareLog::Hooks.init` directly
require 'rails_middleware_log/railtie' if defined?(Rails)
