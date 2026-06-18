require "spec_helper"
require "rails_helper" if defined?(Rails)
require File.expand_path("../config/environment", __dir__)
require "rspec/rails"
require "factory_bot_rails"
require "shoulda-matchers"
require "database_cleaner/active_record"

RSpec.configure do |config|
  # FactoryBot — lets you call create(), build() without the FactoryBot. prefix
  config.include FactoryBot::Syntax::Methods

  # Use transactions to clean the DB between tests.
  # Each test runs, then everything gets rolled back. Fast and reliable.
  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.around(:each) do |example|
    DatabaseCleaner.cleaning { example.run }
  end

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups

  # Shows the full error backtrace for failures — useful while learning
  config.filter_rails_from_backtrace!
end

# Shoulda Matchers — wires it into RSpec + Rails so one-liner matchers work
Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end