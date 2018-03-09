# frozen_string_literal: true

require 'chefspec'
require 'chefspec/berkshelf'
require 'simplecov'
require 'simplecov-console'
require 'coveralls'

RSpec.configure do |c|
  c.add_setting :supported_platforms, default: {
    centos: %w[7.4.1708 6.9],
    debian: %w[9.3 8.10],
    mac_os_x: %w[10.13 10.10],
    redhat: %w[7.4 6.9],
    ubuntu: %w[16.04 14.04],
    windows: %w[10],
    fedora: %w[27 26]
  }
end

SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter.new(
  [
    Coveralls::SimpleCov::Formatter,
    SimpleCov::Formatter::HTMLFormatter,
    SimpleCov::Formatter::Console
  ]
)
SimpleCov.minimum_coverage(100)
SimpleCov.start
