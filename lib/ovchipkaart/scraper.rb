require 'capybara'
require 'capybara/dsl'

Capybara.register_driver :selenium_chrome do |app|
  Capybara::Selenium::Driver.new(app, :browser => :chrome)
end

Capybara.default_driver = :selenium_chrome

class Scraper
  include Capybara::DSL

  def visit_ovchipkaart
    visit('https://www.ov-chipkaart.nl/')
    page.save_screenshot('tmp/screenshot.png')
  end
end
