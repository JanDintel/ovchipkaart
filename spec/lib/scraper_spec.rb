require 'spec_helper'
require 'capybara/rspec'

# The scraper methods can't run independently
RSpec.configure { |config| config.order = 'default' }

describe Scraper do
  subject { described_class.new }

  describe '.scrape' do
    it 'scrapes the ovchipkaart website' do
      expect_any_instance_of(described_class).to receive(:visit_ovchipkaart)
      expect_any_instance_of(described_class).to receive(:login_user)
      expect_any_instance_of(described_class).to receive(:visit_transaction_overview)
      expect_any_instance_of(described_class).to receive(:select_transaction_period)
      expect_any_instance_of(described_class).to receive(:checkbox_all_transactions)
      expect_any_instance_of(described_class).to receive(:download_transaction_history)
      expect_any_instance_of(described_class).to receive(:find_balance)
      described_class.scrape
    end
  end

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

  describe '#select_transaction_period' do
    it 'changes the time period of the transaction history' do
      expect(subject.select_transaction_period).to have_select('periodes', selected: '2013')
    end
  end

  describe '#checkbox_all_transactions' do
    it 'checks on all transactions' do
      expect(subject.checkbox_all_transactions).to have_checked_field('transactiePanel:container:transacties.declareerAlles', checked: true)
    end
  end

  describe '#download_transaction_history' do
    let(:download_path) { Dir.getwd + '/tmp/downloads/*' }

    it 'downloads the transaction history' do
      # Give time to process download before calling downloads count again
      expect{ subject.download_transaction_history; sleep 3 }.to change{ Dir[download_path].length }.by(1)
    end
  end

  describe '#find_balance' do
    it 'scrapes the balance of the transaction overview page' do
      expect(subject.find_balance).to match /(€+\s+\d*,+\d*)+\s*(\(\d*-\d*-\d*\s\d*:\d*\))/
    end
  end
end
