module SafetyAlgorithm
  def self.run(mode)
    case mode
    when 'driving'
      safety_exp = Drive.safety
    when 'cab'
      safety_exp = Cab.safety
    when 'uber'
      safety_exp = Uber.safety
    when 'bus'
      safety_exp = Bus.safety
    when 'subway'
      safety_exp = Train.safety
    when 'bicycling'
      safety_exp = Bike.safety
    when 'divvy'
      safety_exp = Divvy.safety
    when 'walking'
      safety_exp = Walk.safety
    end
    safety_exp
  end
end
