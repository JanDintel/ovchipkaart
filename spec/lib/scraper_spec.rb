require 'spec_helper'
require 'capybara/rspec'

# The scraper methods can't run independently
RSpec.configure { |config| config.order = 'default' }

describe Scraper do
  subject { described_class.new }

  describe '#visit_ovchipkaart' do
    it 'lands on the login page of ovchipkaart' do
      expect(subject.visit_ovchipkaart).to have_content 'Inloggen op Mijn OV-chipkaart'
    end
  end

  describe '#login_user' do
    it 'fills out the user credentials and logs in' do
      expect(subject.login_user).to have_content 'Transactieoverzicht'
    end
  end

  describe '#visit_transaction_overview' do
    it 'visits the transaction overview page' do
      expect(subject.visit_transaction_overview).to have_content 'Mijn transactieoverzicht'
    end
  end

  describe '#download_transaction_history' do
    it 'downloads the transaction history' do
      expect(subject.download_transaction_history).to have_content 'foo'
    end
  end
end
