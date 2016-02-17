require 'rails_middleware_log/version'

module RailsMiddlewareLog
end

# load Rails/Railtie
begin
  require 'rails'
rescue LoadError
  #do nothing
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

# if not using Railtie, call `RailsMiddlewareLog::Hooks.init` directly
if defined? Rails
  require 'rails_middleware_log/railtie'
end