
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "netcash_api/version"

Gem::Specification.new do |spec|
  spec.name = "netcash_api"
  spec.version = NetcashApi::VERSION
  spec.authors = ["Jono Booth"]
  spec.email = ["jonobth@gmail.com"]

  spec.summary = %q{Netcash API gem makes communicating with the Netcash API quick and easy}
  spec.license = "MIT"

  spec.executables = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files = spec.files.grep(%r{^spec/})
  spec.require_paths = ['lib']

  spec.add_development_dependency "bundler", "~> 1.17"
  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency 'rspec-nc'
  spec.add_development_dependency 'webmock'
  spec.add_development_dependency 'factory_bot'
  spec.add_development_dependency 'guard'
  spec.add_development_dependency 'guard-rspec'
  spec.add_development_dependency 'vcr'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'dotenv'
  spec.add_development_dependency 'pry-nav'
  spec.add_development_dependency 'httplog'
  spec.add_development_dependency 'httparty'
  spec.add_development_dependency 'savon'
end
