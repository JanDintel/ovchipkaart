# YAML Configuration
require 'yaml'

# Capybara
require 'capybara'
require 'capybara/dsl'
require 'selenium/webdriver'

Capybara.register_driver :selenium_chrome do |app|
  preferences = {"download" => {"default_directory" => Dir.getwd + '/tmp/downloads', "directory_upgrade" => true, "extensions_to_open" => ""}}
  capabilities = Selenium::WebDriver::Remote::Capabilities.chrome
  capabilities['chromeOptions'] = {'prefs' => preferences}
  Capybara::Selenium::Driver.new(app, :detach => false, :browser => :chrome, :desired_capabilities => capabilities)
end

Capybara.default_driver = :selenium_chrome
