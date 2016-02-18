# Hook file for app
module RailsMiddlewareLog
  class Hooks
    def self.init
      return unless RailsMiddlewareLog.config.target_urls
      ActiveSupport.on_load(:after_initialize) do
        RailsMiddlewareLog::Log.new.init
      end
    end
  end
end
