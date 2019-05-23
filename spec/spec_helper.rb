# frozen_string_literal: true

require File.expand_path('../application', __dir__)

require 'campaigns_discrepancies_detector.rb'
require 'detector.rb'
require 'find_campaign_discrepancies.rb'

RSpec.configure do |config|
  # Enable flags like --only-fa ilures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
