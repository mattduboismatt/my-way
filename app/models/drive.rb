class Drive
  def self.distance(miles)
    if miles < 6
      distance_exp = (0.813*(miles)**3 - 5.723*(miles)**2 - 1.547*(miles) + 100).to_i
    else
      distance_exp = 50
    end
  end


end
