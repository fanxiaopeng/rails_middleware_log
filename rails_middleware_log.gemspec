# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rails_middleware_log/version'

Gem::Specification.new do |spec|
  spec.name          = 'rails_middleware_log'
  spec.version       = RailsMiddlewareLog::VERSION
  spec.authors       = ['fanxiaopeng']
  spec.email         = ['fanxiaopeng515@163.com']

  spec.summary       = 'log every middleware of rails'
  spec.description   = 'Print Log for request when every middleware start in Rails. You can set which request to log, and the content you want to print.'
  spec.homepage      = 'https://github.com/fanxiaopeng/rails_middleware_log'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split("\n")
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.9'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 0'
end
