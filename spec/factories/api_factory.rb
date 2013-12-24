module Factory

  def self.journeys
    [{:datum=>"13-12-2013", :checkin=>"", :vertrek=>"Grote Markt", :checkuit=>"19:57", :bestemming=>"Muurbloemweg", :bedrag=>"1,76", :transactie=>"Reis", :klasse=>"", :product=>"", :opmerkingen=>""},
    {:datum=>"13-12-2013", :checkin=>"", :vertrek=>"Leiden Centraal", :checkuit=>"09:20", :bestemming=>"Haag HS (Den)", :bedrag=>"1,90", :transactie=>"Reis", :klasse=>"2", :product=>"Altijd Voordeel (maandabonnement)", :opmerkingen=>""},
    {:datum=>"12-12-2013", :checkin=>"", :vertrek=>"Haag HS (Den)", :checkuit=>"18:30", :bestemming=>"Leiden Centraal", :bedrag=>"2,60", :transactie=>"Reis", :klasse=>"2", :product=>"Altijd Voordeel (maandabonnement)", :opmerkingen=>""},
    {:datum=>"12-12-2013", :checkin=>"", :vertrek=>"Leiden Centraal", :checkuit=>"09:21", :bestemming=>"Haag HS (Den)", :bedrag=>"1,90", :transactie=>"Reis", :klasse=>"2", :product=>"Altijd Voordeel (maandabonnement)", :opmerkingen=>""}]
  end

  def self.checkins
    [{:datum=>"13-12-2013", :checkin=>"19:38", :vertrek=>"Grote Markt", :checkuit=>"", :bestemming=>"", :bedrag=>"-4,00", :transactie=>"Check-in", :klasse=>"", :product=>"", :opmerkingen=>""},
    {:datum=>"13-12-2013", :checkin=>"08:57", :vertrek=>"Leiden Centraal", :checkuit=>"", :bestemming=>"", :bedrag=>"-10,00", :transactie=>"Check-in", :klasse=>"", :product=>"", :opmerkingen=>""},
    {:datum=>"12-12-2013", :checkin=>"18:10", :vertrek=>"Haag HS (Den)", :checkuit=>"", :bestemming=>"", :bedrag=>"-10,00", :transactie=>"Check-in", :klasse=>"", :product=>"", :opmerkingen=>""},
    {:datum=>"12-12-2013", :checkin=>"08:55", :vertrek=>"Leiden Centraal", :checkuit=>"", :bestemming=>"", :bedrag=>"-10,00", :transactie=>"Check-in", :klasse=>"", :product=>"", :opmerkingen=>""},
    {:datum=>"11-12-2013", :checkin=>"8:10", :vertrek=>"Leiden Centraal", :checkuit=>"", :bestemming=>"", :bedrag=>"-10,00", :transactie=>"Check-in", :klasse=>"", :product=>"", :opmerkingen=>""}]
  end

  def self.forgotten_checkouts
    [{:datum=>"11-12-2013", :checkin=>"8:15", :vertrek=>"Den Haag Laan van NOI", :checkuit=>"", :bestemming=>"", :bedrag=>"-10,00", :transactie=>"Check-in", :klasse=>"", :product=>"", :opmerkingen=>""}]
  end

  def self.additions
    [{:datum=>"12-12-2013", :checkin=>"08:52", :vertrek=>"", :checkuit=>"", :bestemming=>"", :bedrag=>"50,00", :transactie=>"Saldo opgeladen", :klasse=>"", :product=>"", :opmerkingen=>""}]
  end

  def self.products
    [{:datum=>"10-12-2013", :checkin=>"8:00", :vertrek=>"", :checkuit=>"", :bestemming=>"", :bedrag=>"", :transactie=>"Product op kaart gezet", :klasse=>"2", :product=>"Altijd Voordeel (maandabonnement)", :opmerkingen=>""}]
  end

  def self.unclassified
    [{:datum=>"9-12-2013", :checkin=>"7:00", :vertrek=>"", :checkuit=>"", :bestemming=>"", :bedrag=>"", :transactie=>"Foo", :klasse=>"", :product=>"", :opmerkingen=>""}]
  end
end
