$:.push File.expand_path("../lib", __FILE__)
require "ramco/version"

Gem::Specification.new do |spec|
  spec.name          = "ramco"
  spec.version       = Ramco::VERSION
  spec.required_ruby_version = ">= 2.4.6"
  spec.authors       = ["Kurt Kowitz"]
  spec.email         = ["kurt@connectspaceinc.com"]

  spec.summary       = %q{Access RAMCOAMS in ruby.}
  spec.description   = %q{A simple ruby API for accessing RAMCOAMS.}
  spec.homepage      = "https://github.com/message-blocks/ramco"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split("\n")
  spec.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency 'faraday', '~> 0.9'
  spec.add_dependency 'faraday_middleware', '~> 0.9'
  spec.add_dependency 'multi_json', '~> 1.3'
  spec.add_dependency 'typhoeus', '~> 0.7.0'
  
  spec.add_development_dependency "bundler"
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec', '~>3.0'
  spec.add_development_dependency 'json_pure'
  spec.add_development_dependency 'webmock'
  spec.add_development_dependency 'vcr'
  spec.add_development_dependency 'pry-byebug'
end
