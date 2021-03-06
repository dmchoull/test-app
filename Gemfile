source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.5'

# Use PostgreSQL as the database for Active Record
gem 'pg'

# Use Bootstrap framework
gem 'bootstrap-sass'

# font-awesome
gem 'font-awesome-rails'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'

# See https://github.com/rails/execjs#readme for more supported runtimes
gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
gem 'jquery-turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'

# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

# Use Puma as the app server
gem 'puma'

# Authentication
gem 'devise'

# Authorization
gem 'cancancan'

# Roles
gem 'rolify'

gem 'awesome_print'

group :test do
  gem 'shoulda-matchers', require: false
  gem 'rspec-rails'
  gem 'capybara'
  gem 'launchy'
end

group :development do
  gem 'guard-rspec'
  gem 'guard-rubocop'
  gem 'terminal-notifier'
  gem 'terminal-notifier-guard'
  gem 'rb-readline'

  gem 'spring'
  gem 'spring-commands-rspec'

  gem 'rubocop', require: false
  gem 'rubocop-rspec', require: false
  gem 'rubocop-rspec-focused', require: false
end

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'

  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  gem 'fuubar'
  gem 'pry'
  gem 'factory_girl_rails'
end

group :production do
  gem 'rails_12factor'
end

ruby '2.2.3'
