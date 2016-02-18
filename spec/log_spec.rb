require 'spec_helper'
require 'active_support'
require 'rails'
require 'rails_middleware_log/log'
require 'rails_middleware_log/config'
describe 'RailsMiddlewareLog::Log' do
  before do

    class MiddleClass1
      def call
      end
    end
    class Middle1
      def klass
        MiddleClass1
      end
    end
    @middle1 = Middle1.new

    class Middle2
      def klass
        ActiveSupport::Cache::Strategy::LocalCache::Middleware.new('', '')
      end
    end

    @middle2 = Middle2.new
  end
  describe '.init' do
    it 'add old_call method success' do
      RailsMiddlewareLog::Log.init([@middle1, @middle2])
      @middle1.klass.method_defined?(:old_call).equal? true
      @middle2.klass.class.method_defined?(:old_call).equal? true
    end
  end

  describe '.before_call' do
    before do
      @env = { 'PATH_INFO' => '/api/path' }

      module Rails
        def self.logger
          Logger.new(STDOUT)
        end
      end
    end
    describe 'target_urls match null' do
      it 'exec null log' do
        RailsMiddlewareLog.configure do |config|
          config.target_urls = '/error/path'
        end
        result = RailsMiddlewareLog::Log.before_call(MiddleClass1, @env)
        expect(result).to be_nil
      end
    end

    describe 'no config target_urls' do
      it 'exec null log' do
        result = RailsMiddlewareLog::Log.before_call(MiddleClass1, @env)
        expect(result).to be_nil
      end
    end

    describe 'config before_middleware' do
      it 'exec before_middleware code' do
        RailsMiddlewareLog.configure do |config|
          config.target_urls = '/api/path'
          config.before_middleware = ->(name, env){
            env['PATH_INFO']
          }
        end
        result = RailsMiddlewareLog::Log.before_call(MiddleClass1, @env)
        expect(result).to eq @env['PATH_INFO']
      end
    end

    describe 'exec default log' do
      it 'request url match String url' do
        RailsMiddlewareLog.configure do |config|
          config.target_urls = '/api/path'
        end
        result = RailsMiddlewareLog::Log.before_call(MiddleClass1, @env)
        expect(result).to be_truthy
      end
      it 'request url match Boolean url' do
        RailsMiddlewareLog.configure do |config|
          config.target_urls = true
        end
        result = RailsMiddlewareLog::Log.before_call(MiddleClass1, @env)
        expect(result).to be_truthy
      end
      it 'request url match Array url' do
        RailsMiddlewareLog.configure do |config|
          config.target_urls = ['/api/path']
        end
        result = RailsMiddlewareLog::Log.before_call(MiddleClass1, @env)
        expect(result).to be_truthy
      end

      it 'request url match Regexp url' do
        RailsMiddlewareLog.configure do |config|
          config.target_urls = /api/
        end
        result = RailsMiddlewareLog::Log.before_call(MiddleClass1, @env)
        expect(result).to be_truthy
      end
    end
  end
end