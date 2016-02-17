require 'active_support/configurable'

module RailsMiddlewareLog
  # Configures global settings
  #   RailsMiddlewareLog.configure do |config|
  #     config.logger = Logger.new
  #   end
  def self.configure(&block)
    yield @config ||= RailsMiddlewareLog::Configuration.new
  end

  # Global settings
  def self.config
    @config
  end

  # need a Class for 3.0
  class Configuration #:nodoc:
    include ActiveSupport::Configurable
    config_accessor :logger
  end

  # this is ugly. why can't we pass the default value to config_accessor...?
  configure do |config|
    config.logger = 25
  end
end
