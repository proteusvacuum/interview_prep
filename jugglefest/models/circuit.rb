class Circuit < JuggleFestElement
  attr_accessor :potential_jugglers, :offers, :avail_positions
  
  def initialize(circuit)
    super(circuit)
    @potential_jugglers = []
    @offers = []
  end

  def add_potential_juggler(juggler)
    @potential_jugglers << {id: juggler.id, match: juggler.compute_match(self)}
    @potential_jugglers.sort_by! { |pj| pj[:match] }
  end

  def make_next_offer(jugglers)
    if @avail_positions > 0 and @potential_jugglers.length == 0
      # circuit expended all the jugglers that want to juggle here
      # assign the best juggler who is not yet committed here
      get_next_best_potentials(jugglers)
    end

    if @potential_jugglers.length > 0 and @avail_positions > 0
      juggler = jugglers[@potential_jugglers.last[:id]]
      offer = juggler.make_offer(self)
      if offer == :accepted or offer == :relinquished
        @offers << juggler.id
        @potential_jugglers.pop
        @avail_positions -= 1
        return offer == :accepted
      else
        @potential_jugglers.pop
        return false
      end
    else
      return false
    end
  end

  def get_next_best_potentials(jugglers)
    unassigned_jugglers = jugglers.map do |juggler| 
      {id: juggler.id, match: juggler.compute_match(self)} unless juggler.committed 
    end
    @potential_jugglers = unassigned_jugglers.compact.sort_by!{ |pj| pj[:match] }
  end

  def relinquish_offer(juggler)
    @offers.delete(juggler.id)
    add_potential_juggler(juggler)
    @avail_positions += 1
  end

end