# encoding: utf-8

module Ovchipkaart
  class Api
    attr_reader :scraper, :sorted_transactions

    def initialize
      @scraper  = Scraper.scrape
      parser    = Parser.new
      parser.sort_csv_file
      @sorted_transactions = parser
    end

    def balance
      balance_and_date[:balance]
    end

    def exact_balance
      balance_and_date[:balance].match(/\d*[,]\d*/)[0].gsub(',', '.').to_f.round 2
    end

    def last_updated
      balance_and_date[:date]
    end

    def journeys
      sorted_transactions.journeys
    end

    def checkins
      sorted_transactions.check_ins
    end

    def forgotten_checkouts
      sorted_transactions.forgotten_check_outs
    end

    def additions
      sorted_transactions.additions
    end

    def products
      sorted_transactions.products
    end

    def unclassified
      sorted_transactions.others
    end

    private

    def balance_and_date
      regex = scraper.balance.match(/(€.*)(\(.*\))/)
      {balance: regex[1].strip, date: regex[2]}
    end
  end
end
