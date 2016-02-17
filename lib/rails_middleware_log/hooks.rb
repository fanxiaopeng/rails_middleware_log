module RailsMiddlewareLog
  class Hooks
    def self.init
      ActiveSupport.on_load(:after_initialize) do
        Rails.configuration.middleware.middlewares.each do |middleware|
          middleware_class = middleware.klass
          if middleware_class.class === Class && middleware_class.method_defined?(:call)
            middleware_class.class_eval do
              alias :old_call :call

              def call env
                Rails.logger.info "-------#{self.class.name}"
                old_call(env)
              end
            end
          end
        end
      end
    end
  end
end
