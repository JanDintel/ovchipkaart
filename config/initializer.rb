# YAML Configuration
require 'yaml'

# Capybara
require 'capybara'
require 'capybara/dsl'

Capybara.register_driver :selenium_chrome do |app|
  Capybara::Selenium::Driver.new(app, :browser => :chrome)
end

Capybara.default_driver = :selenium_chrome
