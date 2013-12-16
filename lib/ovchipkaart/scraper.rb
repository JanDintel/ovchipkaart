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

  def select_transaction_period
    select('2013', from: 'periodes')
    click_button 'Transacties tonen'
    page.save_screenshot('tmp/screenshot4.png')
    self
  end

  def checkbox_all_transactions
    check('transactiePanel:container:transacties.declareerAlles')
    self
  end

  def download_transaction_history
    click_link 'Opslaan als CSV'
    page.save_screenshot('tmp/screenshot5.png')
    self
  end

  def find_balance
    all('span', text: /[€,\d]/)[5].text
  end

  private

  def need_to_accept_cookies?
    !find_link('Ik accepteer deze cookies').nil?
  end

  def accept_cookies
    click_on('Ik accepteer deze cookies')
  end
end
