source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.1.4'
# bcrypt Gem
gem 'bcrypt', '~> 3.1.11'
# Use postgresql as the database for Active Record
gem 'pg', '1.1.4'
# Use Puma as the app server
gem 'puma', '~> 3.7'
# Bootstrap
gem 'bootstrap', '~> 4.0.0'
# Popper
gem 'popper_js', '~> 1.12.9'
# Importing sprockets-Rails
gem 'sprockets-rails', :require => 'sprockets/railtie'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# jQuery Gem
gem 'jquery-rails'
# pagination gem
gem 'will_paginate', '3.1.5'
# bootstrap pagination Gem
gem 'bootstrap-will_paginate', '1.0.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# font awesome
gem "font-awesome-rails"
# See https://github.com/rails/execjs#readme for more supported runtimes
# Json Gem
gem 'json'
# devise
gem 'devise'
# geocoder
gem 'geocoder'
# pry
gem 'pry'
# gem 'therubyracer', platforms: :ruby
gem 'nokogiri'

# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :production do
  gem 'yarn'
  gem 'rails_12factor'
end

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', '~>10.0.0', platforms: [:mri, :mingw, :x64_mingw]

  %w[rspec-core rspec-expectations rspec-mocks rspec-rails rspec-support].each do |lib|
  gem lib, :git => "https://github.com/rspec/#{lib}.git", :branch => 'master'
  end

  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '~> 2.13'
  gem 'selenium-webdriver'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

# Ruby Version
ruby "2.6.2"
