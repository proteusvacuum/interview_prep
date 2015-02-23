class JuggleFestElement
  attr_reader :id, :hand_eye, :endurance, :pizzazz, :skills
  attr_accessor :fits
  
  def initialize(element)
    @id = element[1][1..-1].to_i
    @hand_eye = element[2][2..-1].to_i
    @endurance = element[3][2..-1].to_i
    @pizzazz = element[4][2..-1].to_i
    @skills = [@hand_eye, @endurance, @pizzazz]
  end

end