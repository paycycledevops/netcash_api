require 'bundler/setup'
require 'netcash_api'
require 'pry'
require 'webmock/rspec'
require 'factory_bot'
require 'httplog'
require 'vcr'

VCR.configure do |config|
  config.cassette_library_dir = "fixtures/vcr_cassettes"
  config.hook_into :webmock
end

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.include FactoryBot::Syntax::Methods

  config.before :all do
    FactoryBot.find_definitions
  end
end

HttpLog.configure do |config|
  config.log_headers = false
  config.color = :yellow
end
