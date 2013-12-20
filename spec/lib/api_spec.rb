require 'spec_helper'

describe Api do
  let(:journeys) do
    [{:datum=>"13-12-2013", :checkin=>"", :vertrek=>"Grote Markt", :checkuit=>"19:57", :bestemming=>"Muurbloemweg", :bedrag=>"1,76", :transactie=>"Reis", :klasse=>"", :product=>"", :opmerkingen=>""},
    {:datum=>"13-12-2013", :checkin=>"", :vertrek=>"Leiden Centraal", :checkuit=>"09:20", :bestemming=>"Haag HS (Den)", :bedrag=>"1,90", :transactie=>"Reis", :klasse=>"2", :product=>"Altijd Voordeel (maandabonnement)", :opmerkingen=>""},
    {:datum=>"12-12-2013", :checkin=>"", :vertrek=>"Haag HS (Den)", :checkuit=>"18:30", :bestemming=>"Leiden Centraal", :bedrag=>"2,60", :transactie=>"Reis", :klasse=>"2", :product=>"Altijd Voordeel (maandabonnement)", :opmerkingen=>""},
    {:datum=>"12-12-2013", :checkin=>"", :vertrek=>"Leiden Centraal", :checkuit=>"09:21", :bestemming=>"Haag HS (Den)", :bedrag=>"1,90", :transactie=>"Reis", :klasse=>"2", :product=>"Altijd Voordeel (maandabonnement)", :opmerkingen=>""}]
  end

  let(:checkins) do
    [{:datum=>"13-12-2013", :checkin=>"19:38", :vertrek=>"Grote Markt", :checkuit=>"", :bestemming=>"", :bedrag=>"-4,00", :transactie=>"Check-in", :klasse=>"", :product=>"", :opmerkingen=>""},
    {:datum=>"13-12-2013", :checkin=>"08:57", :vertrek=>"Leiden Centraal", :checkuit=>"", :bestemming=>"", :bedrag=>"-10,00", :transactie=>"Check-in", :klasse=>"", :product=>"", :opmerkingen=>""},
    {:datum=>"12-12-2013", :checkin=>"18:10", :vertrek=>"Haag HS (Den)", :checkuit=>"", :bestemming=>"", :bedrag=>"-10,00", :transactie=>"Check-in", :klasse=>"", :product=>"", :opmerkingen=>""},
    {:datum=>"12-12-2013", :checkin=>"08:55", :vertrek=>"Leiden Centraal", :checkuit=>"", :bestemming=>"", :bedrag=>"-10,00", :transactie=>"Check-in", :klasse=>"", :product=>"", :opmerkingen=>""},
    {:datum=>"11-12-2013", :checkin=>"8:10", :vertrek=>"Leiden Centraal", :checkuit=>"", :bestemming=>"", :bedrag=>"-10,00", :transactie=>"Check-in", :klasse=>"", :product=>"", :opmerkingen=>""}]
  end

  let(:forgotten_checkouts) do
    [{:datum=>"11-12-2013", :checkin=>"8:15", :vertrek=>"Den Haag Laan van NOI", :checkuit=>"", :bestemming=>"", :bedrag=>"-10,00", :transactie=>"Check-in", :klasse=>"", :product=>"", :opmerkingen=>""}]
  end

  let(:additions) do
    [{:datum=>"12-12-2013", :checkin=>"08:52", :vertrek=>"", :checkuit=>"", :bestemming=>"", :bedrag=>"50,00", :transactie=>"Saldo opgeladen", :klasse=>"", :product=>"", :opmerkingen=>""}]
  end

  let(:unclassified) { [] }

  let(:products) do
    [{:datum=>"10-12-2013", :checkin=>"8:00", :vertrek=>"", :checkuit=>"", :bestemming=>"", :bedrag=>"", :transactie=>"Product op kaart gezet", :klasse=>"2", :product=>"Altijd Voordeel (maandabonnement)", :opmerkingen=>""}]
  end

  describe 'public API' do
    let(:csv_file)  { File.read 'spec/fixtures/test_transaction_1.csv' }
    before { Parser.any_instance.stub(:csv_file).and_return csv_file }

    specify { expect(subject.balance).to              eql 'foo' }
    specify { expect(subject.journeys).to             eql journeys }
    specify { expect(subject.checkins).to             eql checkins }
    specify { expect(subject.forgotten_checkouts).to  eql forgotten_checkouts }
    specify { expect(subject.additions).to            eql additions }
    specify { expect(subject.products).to             eql products }
    specify { expect(subject.unclassified).to         eql unclassified }
  end
end
