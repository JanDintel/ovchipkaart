source 'https://rubygems.org'

gemspec

group :web_driver do
  gem 'capybara'
  gem 'selenium-webdriver'
  gem 'chromedriver-helper', github: 'mars/chromedriver-helper', ref: '3be3d'
end

group :development, :test do
  gem 'pry', require: false
  gem 'rspec'
end

group :test do
  gem 'coveralls', require: false
  gem 'rake'
end
