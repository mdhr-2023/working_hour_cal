# frozen_string_literal: true

source 'https://rubygems.org'

gem 'bootsnap', require: false
gem 'puma'
gem 'rails','~> 7.0.0'
gem 'rubocop-rails', require: false
gem 'sqlite3', '~> 1.4'

group :development do
  gem 'listen'
  gem 'spring'
end

group :test do
  gem 'ci_reporter_rspec'
  gem 'database_cleaner'
end

group :development, :test do
  gem 'rspec-rails'
  gem 'pry'
end
