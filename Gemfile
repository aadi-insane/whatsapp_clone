source 'https://rubygems.org'

ruby '3.0.0'

# Rails framework
gem 'rails', '~> 7.1.0'

# Database
gem 'pg', '~> 1.6'

# Web server
gem 'puma', '~> 6.0'

# Authentication
gem 'devise'
gem 'devise-jwt'  # optional, token-based auth

# Real-time messaging
gem 'redis', '~> 5.0'  # Required for Action Cable in production

# File uploads (images, videos, etc.)
gem 'image_processing', '~> 1.2'

# Frontend & UI
gem 'stimulus-rails'
gem 'turbo-rails'
gem 'sprockets-rails'
gem 'importmap-rails'

# JSON builder (API support if needed)
gem 'jbuilder', '~> 2.11'

# Optional utilities
gem 'dotenv-rails', groups: [:development, :test]  # environment variables
gem 'sidekiq', '~> 7.0'  # background jobs (optional for notifications)

# Reduces boot times through caching
gem 'bootsnap', require: false

# Windows tzinfo-data
gem 'tzinfo-data', platforms: %i[ mswin mswin64 mingw x64_mingw ]

group :development, :test do
  gem 'debug', platforms: %i[ mri mswin mswin64 mingw x64_mingw ]
  gem 'bullet'
end

group :development do
  gem 'web-console'
end

group :test do
  gem 'capybara'
  gem 'selenium-webdriver'
end
