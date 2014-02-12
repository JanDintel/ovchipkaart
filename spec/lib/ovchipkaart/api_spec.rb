# encoding: utf-8
require 'spec_helper'

describe Ovchipkaart::Api do

  describe 'public API' do
    @scraper = Ovchipkaart::Scraper.scrape

    before do
      Ovchipkaart::Parser.any_instance.stub(:csv_file)  { Factory.csv_file }
      Ovchipkaart::Api.any_instance.stub(:scraper)      { @scraper }
    end

    specify { expect(subject.journeys).to             eql Factory.journeys }
    specify { expect(subject.checkins).to             eql Factory.checkins }
    specify { expect(subject.forgotten_checkouts).to  eql Factory.forgotten_checkouts }
    specify { expect(subject.additions).to            eql Factory.additions }
    specify { expect(subject.products).to             eql Factory.products }
    specify { expect(subject.unclassified).to         eql Factory.unclassified }

    context 'with web_driver', :web_driver do

      before do
        allow_message_expectations_on_nil
        @scraper.stub(:balance).and_return "€ 30,51 (19-12-2013 20:57)"
      end

      specify { expect(subject.balance).to              eql '€ 30,51' }
      specify { expect(subject.exact_balance).to        eq 30.51 }
      specify { expect(subject.last_updated).to         eql '(19-12-2013 20:57)' }
    end
  end
end
