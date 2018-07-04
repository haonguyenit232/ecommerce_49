source "https://rubygems.org"

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem "rails", "~> 5.1.6"
gem "bcrypt", "~> 3.1.7"
gem "bootstrap", "~> 4.1.1"
gem "bootstrap-will_paginate", "1.0.0"
gem "font-awesome-rails"
gem "i18n-js"
gem "turbolinks"
gem "jquery-rails"
gem "jquery-ui-sass-rails"
gem "mysql2", ">= 0.3.18", "< 0.6.0"
gem "puma", "~> 3.7"
gem "rubocop", "~> 0.49.1", require: false
gem "sass-rails", "~> 5.0"
gem "uglifier", ">= 1.3.0"
gem "carrierwave", "1.2.2"
gem "devise"
gem "cancancan", "~> 2.0"
gem "mini_magick", "4.7.0"
gem "config"
gem "will_paginate", "3.1.6"
gem "jquery-turbolinks"
gem "rails-ujs"

group :development, :test do
  gem "byebug", platforms: [:mri, :mingw, :x64_mingw]
  gem "capybara", "~> 2.13"
  gem "selenium-webdriver"
end

group :development do
  gem "web-console", ">= 3.3.0"
  gem "listen", ">= 3.0.5", "< 3.2"
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
  gem "pry-rails"
end

gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
