require 'active_support/configurable'
# config file
module RailsMiddlewareLog
  # Configures global settings
  #   RailsMiddlewareLog.configure do |config|
  #     config.logger = Logger.new
  #   end
  def self.configure(&_block)
    yield @config ||= RailsMiddlewareLog::Configuration.new
  end

  # Global settings
  def self.config
    @config || configure { |config| config }
  end

  # need a Class for 3.0
  class Configuration #:nodoc:
    include ActiveSupport::Configurable
    config_accessor(:target_urls)
    config_accessor(:before_middleware)
  end
end
