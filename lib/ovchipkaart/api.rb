class Api
  attr_reader :scraper, :parser

  def initialize
    @scraper = scrape_ovchipkaart
    @parser = parse_transactions
  end

  def balance
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

  def scrape_ovchipkaart
    scraper = Scraper.new
  end

  def parse_transactions
    parser = Parser.new
    parser.sort_csv_file
    @parser ||= parser
  end
end
