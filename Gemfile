source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.0.0"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 7.0.3", ">= 7.0.3.1"

# The original asset pipeline for Rails [https://github.com/rails/sprockets-rails]
gem "sprockets-rails"

# Use sqlite3 as the database for Active Record
gem "sqlite3", "~> 1.4"


# Use the Puma web server [https://github.com/puma/puma]
gem "puma", "~> 5.0"

# Use JavaScript with ESM import maps [https://github.com/rails/importmap-rails]
gem "importmap-rails"

# Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem "turbo-rails"

# Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem "stimulus-rails"

# Use Tailwind CSS [https://github.com/rails/tailwindcss-rails]

# Build JSON APIs with ease [https://github.com/rails/jbuilder]
gem "jbuilder"

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem "bcrypt", "~> 3.1.7"

gem 'timeout'
# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false

# Use Sass to process CSS
# gem "sassc-rails"

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
gem "image_processing", "~> 1.2"

group :development, :test do
  gem "factory_bot_rails"
  gem "hotwire-livereload", "~> 1.2"
  gem "mailcatcher", "~> 0.2.4"
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
  gem "rspec-rails", "~> 5.1"
end

group :development do
  gem "web-console"
  gem "debug"
end

group :production do
  # Use Redis adapter to run Action Cable in production
  gem "redis", "~> 4.0"
end

group :test do
  # Use system testing [https://guides.rubyonrails.org/testing.html#system-testing]
  gem "capybara"
  gem "selenium-webdriver"
  gem "shoulda-matchers", "~> 5.0"
  gem "simplecov", require: false
  gem "webdrivers"
end

gem "font-awesome-sass", "~> 6.1.1"
gem 'sass-rails'

# PostGres SQL
gem "pg"

gem "rmagick"

gem "devise", "~> 4.8"

gem "tailwindcss-rails", "~> 2.0"

gem 'friendly_id', '~> 5.4.0'

gem "noticed", "~> 1.5"

gem "concurrent-ruby", "~> 1.0"

gem "foreman", "~> 0.87.2"

gem "pagy", "~> 5.10"
