# encoding: utf-8
require 'spec_helper'

describe Ovchipkaart::Api do
  let(:csv_file)            { Factory.csv_file }
  let(:journeys)            { Factory.journeys }
  let(:checkins)            { Factory.checkins }
  let(:forgotten_checkouts) { Factory.forgotten_checkouts }
  let(:additions)           { Factory.additions }
  let(:products)            { Factory.products }
  let(:unclassified)        { [] }

  describe 'public API' do
    before { Ovchipkaart::Parser.any_instance.stub(:csv_file).and_return csv_file }

    specify { expect(subject.journeys).to             eql journeys }
    specify { expect(subject.checkins).to             eql checkins }
    specify { expect(subject.forgotten_checkouts).to  eql forgotten_checkouts }
    specify { expect(subject.additions).to            eql additions }
    specify { expect(subject.products).to             eql products }
    specify { expect(subject.unclassified).to         eql unclassified }

    context 'with web_driver', :web_driver do
      before { Ovchipkaart::Scraper.any_instance.stub(:balance).and_return "€ 30,51 (19-12-2013 20:57)" }

      specify { expect(subject.balance).to              eql '€ 30,51' }
      specify { expect(subject.last_updated).to         eql '(19-12-2013 20:57)' }
    end
  end
end
