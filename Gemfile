# frozen_string_literal: true

source 'https://rubygems.org'

gem 'berkshelf'
gem 'rake'

group :development do
  gem 'guard'
  gem 'guard-foodcritic'
  gem 'guard-kitchen'
  gem 'guard-rspec'
end

group :unit do
  gem 'chefspec'
  gem 'coveralls'
  gem 'rspec'
  gem 'simplecov'
  gem 'simplecov-console'
end

group :lint do
  gem 'foodcritic'
  gem 'rubocop'
end

group :integration do
  gem 'kitchen-docker'
  gem 'kitchen-localhost'
  gem 'kitchen-vagrant'
  gem 'serverspec'
  gem 'test-kitchen'
  gem 'winrm-fs'
end

group :deployment do
  gem 'stove'
end
