# encoding: utf-8
require 'spec_helper'

describe Ovchipkaart::Parser do
  let(:csv_file)      { Factory.csv_file }
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

    specify { expect(subject.journeys.count).to       eql 4 }
    specify { expect(subject.check_ins.count).to      eql 5 }
    specify { expect(subject.additions.count).to      eql 1 }
    specify { expect(subject.products.count).to       eql 1 }
    specify { expect(subject.others.count).to         eql 1 }
    specify {
      expect(subject.forgotten_check_outs.count).to   eql 1 }
  end

  describe '#parse_csv_file' do
    before  { csv_file_stub }

    it 'parses the csv file' do
      expect(CSV).to receive(:new).with(csv_file, { headers: true, header_converters: :symbol, col_sep: ";" })
      subject.parse_csv_file
    end
  end

  describe 'downloaded csv file' do
    let(:tmp_dir)     { "#{Dir.getwd}/tmp/downloads"}
    let(:file_1_path) { "#{tmp_dir}/transactie_14.csv" }
    let(:file_2_path) { "#{tmp_dir}/transactie_13.csv" }

    before do
      FileUtils.mkdir_p tmp_dir
      File.open(file_1_path, 'w+') { |file| file.write csv_file }
      File.new file_2_path, 'w+'
    end

    after do
      FileUtils.rm file_1_path
      FileUtils.rm file_2_path
    end

    context '#csv_file' do
      context 'when present' do
        specify { expect(subject.csv_file).to eql csv_file }
      end

      context 'when NOT present' do
        specify do
          subject.stub(:last_downloaded_file) { nil }
          expect(subject.csv_file).to eql nil
        end
      end
    end

    context '#last_downloaded_file' do
      it 'sorts the file on their basename and returns last one' do
        expect("#{Dir.getwd}/#{subject.last_downloaded_file}").to eql file_1_path
      end
    end
  end
end
