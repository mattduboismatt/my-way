class Route < ActiveRecord::Base
  after_initialize :set_defaults
  belongs_to :trip

  def set_defaults
    self.distance_exp = 0
    self.duration_exp = 0
    self.dollars_exp = 0
    self.weather_exp = 0
    self.safety_exp = 0
    self.comfort_exp = 0
    self.total_exp = 0
  end
end
