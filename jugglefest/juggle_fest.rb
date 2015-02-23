Dir[File.dirname(__FILE__) + '/lib/*.rb'].each {|file| require file }
Dir[File.dirname(__FILE__) + '/models/*.rb'].each {|file| require file }
Dir[File.dirname(__FILE__) + '/controllers/*.rb'].each {|file| require file }

jfm = JuggleFestMatcher.new
jfm.parse_input("data1")
jfm.add_jugglers_to_circuits
jfm.make_offers
puts jfm.circuits[1970].offers.inject{|sum, i| sum + i }
