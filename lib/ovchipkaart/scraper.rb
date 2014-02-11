# encoding: utf-8
module Ovchipkaart
  class Scraper
    attr_reader :balance

    include Capybara::DSL

    Capybara.app_host = 'https://www.ov-chipkaart.nl'

    def self.scrape
      scraper = new
      scraper.visit_ovchipkaart
      scraper.login_user
      scraper.visit_transaction_overview
      scraper.find_balance
      scraper.select_transaction_period
      scraper.checkbox_all_transactions
      scraper.download_transaction_history
      scraper
    end

    def visit_ovchipkaart
      visit('/login/')
      accept_cookies if need_to_accept_cookies?
      self
    end

    def login_user
      fill_in 'gebruikersnaam', with: Ovchipkaart.config[:username]
      fill_in 'wachtwoord',     with: Ovchipkaart.config[:password]
      click_button 'Inloggen'
      self
    end

    def visit_transaction_overview
      click_link 'Transactieoverzicht'
      self
    end

    def find_balance
      @balance = all('span', text: /[€,\d]/)[6].text
    end

    def select_transaction_period
      select('2013', from: 'periodes')
      click_button 'Transacties tonen'
      self
    end

    def checkbox_all_transactions
      check('transactiePanel:container:transacties.declareerAlles')
      self
    end

    def download_transaction_history
      click_link 'Opslaan als CSV'
      File.open("#{Dir.getwd}/tmp/downloads/transactie_#{Time.now.utc.to_i}.csv", 'w+') { |file| file.write self.body }
    end

    private

    def need_to_accept_cookies?
      !find_link('Ik accepteer deze cookies').nil? rescue Capybara::ElementNotFound
    end

    def accept_cookies
      click_on('Ik accepteer deze cookies') rescue Capybara::ElementNotFound
    end
  end
end
