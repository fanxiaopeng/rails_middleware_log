module RailsMiddlewareLog
  class Railtie < ::Rails::Railtie #:nodoc:
    initializer 'rails_middleware_log' do |_app|
      RailsMiddlewareLog::Hooks.init
    end
  end
end
