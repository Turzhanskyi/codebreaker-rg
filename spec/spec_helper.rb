# frozen_string_literal: true

PLUS = '+'
MINUS = '-'

require 'codebreaker'
require 'simplecov'

SimpleCov.start do
  enable_coverage :branch
  add_filter 'spec/'
  minimum_coverage 95
end

RSpec.configure do |config|
  config.example_status_persistence_file_path = '.rspec_status'
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
