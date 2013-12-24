module Factory

  def self.csv_file
    File.read 'spec/fixtures/test_transaction_1.csv'
  end
end
