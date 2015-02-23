class JuggleFestMatcher
  attr_reader :circuits, :jugglers, :avail_positions

  def parse_input(file)
    file_reader = JuggleFestUtils::JuggleFestFileReader.new(file)
    @circuits = file_reader.circuits
    @jugglers = file_reader.jugglers
    @circuits.each{|c| c.avail_positions = @jugglers.length / @circuits.length}
    @avail_positions = @jugglers.length
  end
  
  def add_jugglers_to_circuits
    @jugglers.each do |juggler|
      juggler.preferences.each do |pref|
        @circuits[pref.to_i].add_potential_juggler(juggler)
      end
    end
  end

  def make_offers
    while @avail_positions > 0
      @circuits.each do |circuit|
        if circuit.avail_positions > 0
          offer = circuit.make_next_offer(@jugglers)
          if offer
            @avail_positions = @avail_positions - 1
          end
        end
      end
    end
  end
  
end