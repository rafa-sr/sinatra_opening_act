# frozen_string_literal: true

ENV['RACK_ENV'] = 'test'

require 'rack/test'
require 'simplecov'
require 'bundler'
require 'webmock/rspec'
require 'open3'

def app
  Sinatra::Application
end

SimpleCov.start do
  add_group 'Models', 'models'
  add_group 'Controllers', 'controllers'
  add_group 'Services', 'service'
  add_filter %W[ /config/ vendor spec]
  minimum_coverage 90
end

# Load the Sinatra app
require File.join(File.dirname(__FILE__), '..', 'app' )
Bundler.require(:default,:test)

# Disable webrequests
WebMock.disable_net_connect!(allow_localhost: true)

set :environment, :test
RSpec.configure do |config|
  config.profile_examples = 5
  config.include Rack::Test::Methods
  config.include JsonSpec::Helpers
  config.order = :random

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  # rspec-mocks config goes here. You can use an alternate test double
  # library (such as bogus or mocha) by changing the `mock_with` option here.
  config.mock_with :rspec do |mocks|
    mocks.verify_doubled_constant_names = true
    mocks.verify_partial_doubles = true
  end

  config.after :suite do
    unless ENV['TEST_LINTER_OFF'] == 'true'
      puts ''
      rubocop_command = 'bundle exec rubocop'
      raise 'Rubocop Errors' unless system rubocop_command
    end
  end

  # This option will default to `:apply_to_host_groups` in RSpec 4 (and will
  # have no way to turn it off -- the option exists only for backwards
  # compatibility in RSpec 3). It causes shared context metadata to be
  # inherited by the metadata hash of host groups and examples, rather than
  # triggering implicit auto-inclusion in groups with matching metadata.
  config.shared_context_metadata_behavior = :apply_to_host_groups


=begin
  # This allows you to limit a spec run to individual examples or groups
  # you care about by tagging them with `:focus` metadata. When nothing
  # is tagged with `:focus`, all examples get run. RSpec also provides
  # aliases for `it`, `describe`, and `context` that include `:focus`
  # metadata: `fit`, `fdescribe` and `fcontext`, respectively.

config.filter_run_when_matching :focus

  # Allows RSpec to persist some state between runs in order to support
  # the `--only-failures` and `--next-failure` CLI options. We recommend
  # you configure your source control system to ignore this file.
  config.example_status_persistence_file_path = "spec/examples.txt"

=end
end
