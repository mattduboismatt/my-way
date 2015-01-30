module SafetyAlgorithm
  def self.run(mode)
    hour = Time.now.hour
    case hour
    when 7..19
      safety_exp = 100
    when 20..21, 6..8
      case mode
      when 'driving'
        safety_exp = 100
      when 'cab'
        safety_exp = 95
      when 'uber'
        safety_exp = 90
      when 'bus', 'subway', 'bicycling', 'divvy'
        safety_exp = 80
      when 'walking'
        safety_exp = 70
      end

    when 22..23, 0..5
      case mode
      when 'driving'
        safety_exp = 100
      when 'cab'
        safety_exp = 85
      when 'uber'
        safety_exp = 80
      when 'bus', 'subway', 'bicycling', 'divvy'
        safety_exp = 40
      when 'walking'
        safety_exp = 0
      end
    end
    safety_exp
  end
end
