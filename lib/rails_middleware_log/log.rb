# log file when processing
module RailsMiddlewareLog
  class Log
    def init
      Rails.configuration.middleware.middlewares.each do |middleware|
        klass = middleware_class(middleware)
        return unless klass.method_defined? :call
        klass.class_eval do
          alias_method :old_call, :call

          def call(env)
            RailsMiddlewareLog::Log.before_call(self.class, env)
            old_call(env)
          end
        end
      end
    end

    # get the current middleware class
    def middleware_class(middleware)
      case middleware.klass
      when ActiveSupport::Cache::Strategy::LocalCache::Middleware
        middleware.klass.class
      when Class
        middleware.klass
      else
        normalize(middleware)
      end
    end

    class << self
      def before_call(k_class, env)
        if config_url_match?(env['PATH_INFO'])
          if block = RailsMiddlewareLog.config.before_middleware
            block.call(k_class, env)
          else
            Rails.logger.info "-------#{k_class.name}"
          end
        end
      end

      # check current request
      def config_url_match?(url)
        target_urls = RailsMiddlewareLog.config.target_urls
        case target_urls
        when true
          true
        when String
          target_urls == url
        when Array
          target_urls.include? url
        when Regexp
          target_urls === url
        else
          false
        end
      end
    end

    private

    def normalize(object)
      object.to_s.strip.sub(/^::/, '')
    end
  end
end
