require 'capybara'
require 'capybara/dsl'

Capybara.register_driver :selenium_chrome do |app|
  Capybara::Selenium::Driver.new(app, :browser => :chrome)
end

Capybara.default_driver = :selenium_chrome

class Scraper
  include Capybara::DSL

  def visit_ovchipkaart
    visit('https://www.ov-chipkaart.nl/login/')
    page.save_screenshot('tmp/screenshot1.png')
    accept_cookies if need_to_accept_cookies?
    self
  end

  def login_user
    fill_in 'gebruikersnaam', with: Ovchipkaart.config[:username]
    fill_in 'wachtwoord',     with: Ovchipkaart.config[:password]
    click_button 'Inloggen'
    page.save_screenshot('tmp/screenshot2.png')
    self
  end

  def visit_transaction_overview
    click_link 'Transactieoverzicht'
    page.save_screenshot('tmp/screenshot3.png')
    self
  end

  def download_transaction_history
    click_link 'Opslaan als CSV'
    page.save_screenshot('tmp/screenshot4.png')
    self
  end

  private

  def need_to_accept_cookies?
    !find_link('Ik accepteer deze cookies').nil?
  end

  def accept_cookies
    click_on('Ik accepteer deze cookies')
  end
end
