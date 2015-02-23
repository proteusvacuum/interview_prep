class Juggler < JuggleFestElement
  attr_accessor :preferences, :committed, :current_offer
  
  def initialize(juggler)
    super(juggler)
    @preferences = juggler[5].split(",C")
    @preferences[0] = @preferences[0][1..-1]
    @preferences = @preferences.map(&:to_i)
    @committed = false
  end

  def compute_match(circuit)
    JuggleFestUtils.dot_product(@skills, circuit.skills)
  end

  def make_offer(circuit)
    if @committed
      new_offer_preference = @preferences.index(circuit.id)
      old_offer_preference = @preferences.index(@current_offer.id)
    
      if (old_offer_preference.nil? and !new_offer_preference.nil?) or ( 
            (!old_offer_preference.nil? and !new_offer_preference.nil?) and
            (new_offer_preference < old_offer_preference)
          )
        @current_offer.relinquish_offer(self)
        @current_offer = circuit
        return :relinquished
      else
        return :declined
      end
    else
      @current_offer = circuit
      @committed = true
      return :accepted
    end
  end

end