require 'csv'

class Parser
  attr_reader :journeys, :check_ins, :additions, :others, :products

  def initialize
    @journeys   = []
    @check_ins  = []
    @additions  = []
    @others     = []
    @products   = []
  end

  def self.process_transactions
    new.sort_csv_file
  end

  def sort_csv_file
    transactions.each do |row|
      transactie = row[:transactie]
      if transactie     == "Reis"
        journeys << row
      elsif transactie  == "Check-in"
        check_ins << row
      elsif transactie  == "Saldo opgeladen"
        additions << row
      elsif transactie  == "Product op kaart gezet"
        products << row
      else
        others << row
      end
    end
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
