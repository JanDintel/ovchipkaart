require 'spec_helper'

describe Parser do
  let(:csv_file_path) { 'spec/fixtures/test_transaction_1.csv' }
  let(:csv_file)      { File.read 'spec/fixtures/test_transaction_1.csv' }
  let(:csv_file_stub) { described_class.any_instance.stub(:csv_file).and_return csv_file }

  describe '.process_transactions' do
    it 'sorts the transactions' do
      expect_any_instance_of(described_class).to receive :sort_csv_file
      described_class.process_transactions
    end
  end

  describe '#sort_csv_file' do
    before  { csv_file_stub }
    before  { subject.sort_csv_file }

    specify { expect(subject.journeys.count).to   eql 4 }
    specify { expect(subject.check_ins.count).to  eql 6 }
    specify { expect(subject.additions.count).to  eql 1 }
    specify { expect(subject.products.count).to   eql 1 }
    specify { expect(subject.others.count).to     eql 0 }
  end

  describe '#parse_csv_file' do
    before  { csv_file_stub }

    it 'parses the csv file' do
      expect(CSV).to receive(:new).with(csv_file, { headers: true, header_converters: :symbol, col_sep: ";" })
      subject.parse_csv_file
    end
  end

  describe 'downloaded csv file' do
    let(:file_1_path) { Dir.getwd + '/tmp/downloads/transacties_-0001.csv' }
    let(:file_2_path) { Dir.getwd + '/tmp/downloads/transacties_-0002.csv' }

    before do
      File.open(file_1_path, 'w+') { |file| file.write csv_file }
      File.new file_2_path, 'w+'
    end

    after do
      FileUtils.rm file_1_path
      FileUtils.rm file_2_path
    end

    context '#csv_file' do
      specify { expect(subject.csv_file).to eql csv_file }
    end

    context '#last_downloaded_file' do
      it 'sorts the file on their basename and returns first one' do
        expect(subject.last_downloaded_file).to eql 'tmp/downloads/transacties_-0001.csv'
      end
    end
  end
end
