source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.2.2'

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem 'rails', '~> 7.0.4'

# The original asset pipeline for Rails [https://github.com/rails/sprockets-rails]
gem 'sprockets-rails'

# Use postgresql as the database for Active Record
gem 'pg', '~> 1.1'

# Use the Puma web server [https://github.com/puma/puma]
gem 'puma', '~> 5.0'

# Use JavaScript with ESM import maps [https://github.com/rails/importmap-rails]
gem 'importmap-rails'

# Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem 'turbo-rails'

# Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem 'stimulus-rails'

# Build JSON APIs with ease [https://github.com/rails/jbuilder]
gem 'jbuilder'

# Use Redis adapter to run Action Cable in production
# gem "redis", "~> 4.0"

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem "bcrypt", "~> 3.1.7"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', require: false

# Use Sass to process CSS
# gem "sassc-rails"

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
gem 'image_processing', '~> 1.2'

gem 'activeadmin'
gem 'aws-sdk', '~> 3'
gem 'aws-sdk-s3', '~> 1'
gem 'bootstrap'
gem 'cancancan'
gem 'devise'
# gem 'elasticsearch', '~> 8'
gem 'jquery-rails'
gem 'phonelib'
gem 'sassc-rails'
gem 'simple_form'
gem 'twilio-ruby', '~> 5.74.5'
# gem "searchkick"
# gem "opensearch-ruby"
gem 'graphql', '~> 2.1'
gem 'rack-cors'

group :development, :test do
  gem 'capybara'
  gem 'database_cleaner-active_record'
  gem 'debug', platforms: %i[mri mingw x64_mingw]
  gem 'dotenv-rails'
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'ffaker'
  gem 'mailcatcher'
  gem 'rails-controller-testing'
  gem 'rspec-rails', '~> 5.0.1'
  gem 'selenium-webdriver'
  gem 'shoulda-matchers', '~> 5.0'
  gem 'webdrivers'
end

group :development do
  gem 'capistrano', '~> 3.17', require: false
  gem 'capistrano-passenger'
  gem 'capistrano-rails', '~> 1.6', require: false
  gem 'capistrano-rbenv', '~> 2.2'
  gem 'graphiql-rails', github: 'rmosolgo/graphiql-rails'
  gem 'rubocop', '~> 1.16', require: false
  gem 'rubocop-faker'
  gem 'web-console'
end

gem 'dockerfile-rails', '>= 1.6', group: :development

gem 'redis', '~> 5.3'
