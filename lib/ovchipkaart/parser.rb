# coding: utf-8
require 'csv'

module Ovchipkaart
  class Parser
    attr_reader :journeys, :check_ins, :additions, :others, :products, :forgotten_check_outs

    def initialize
      @journeys   = []
      @check_ins  = []
      @additions  = []
      @others     = []
      @products   = []
      @forgotten_check_outs = []
    end

    def self.process_transactions
      new.sort_csv_file
    end

    def sort_csv_file
      transactions_enum = transactions.each
      begin
        transaction = transactions_enum.next
        case transaction[:transactie]
        when "Reis"
          journeys << transaction
        when "Check-in"
          if transactions_enum.peek[:transactie] == "Check-in"
            forgotten_check_outs << transaction
          else
            check_ins << transaction
          end
        when "Saldo opgeladen"
          additions << transaction
        when "Product op kaart gezet"
          products << transaction
        else
          others << transaction
        end
      rescue StopIteration
        break
      end while true
    end

    def parse_csv_file
      CSV.new(csv_file, headers: true, header_converters: :symbol, col_sep: ';')
    end

    def csv_file
      File.read last_downloaded_file
    end

    def last_downloaded_file
      Dir['tmp/downloads/*'].sort_by{ |f| File.basename(f) }.first
    end

    private

    def transactions
      @transactions ||= parse_csv_file.to_a.map { |row| row.to_hash }
    end
  end
end
