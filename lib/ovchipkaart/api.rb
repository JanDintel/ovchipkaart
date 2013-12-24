# coding: utf-8
module Ovchipkaart
  class Api
    attr_reader :parser

    def initialize
      @parser = parse_transactions
    end

    def balance
      balance_and_date[:balance]
    end

    def last_updated
      balance_and_date[:date]
    end

    def journeys
      parser.journeys
    end

    def checkins
      parser.check_ins
    end

    def forgotten_checkouts
      parser.forgotten_check_outs
    end

    def additions
      parser.additions
    end

    def products
      parser.products
    end

    def unclassified
      parser.others
    end

    private

    def balance_and_date
      regex = scraper.balance.match(/(€.*)(\(.*\))/)
      {balance: regex[1].strip, date: regex[2]}
    end

    def scraper
      @scraper ||= Scraper.scrape
    end

    def parse_transactions
      parser = Parser.new
      parser.sort_csv_file
      @parser ||= parser
    end
  end
end
