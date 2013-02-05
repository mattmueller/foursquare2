require 'foursquare2'

client = Foursquare2::Client.new(:oauth_token => '2A4P25F1Q0ZCPFKPV0WYBAQ2P0ACKLXDPXM24A400SK55BWC')

puts "client initialize"

venueId=['50c07df6067db4a371c7902b','50c0ffa6067d2a087c00cb05']

venuegroup=client.add_venuegroup(:name => 'Venues Managed 4', :venueId => venueId)

puts venuegroup.inspect
