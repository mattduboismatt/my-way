class User < ActiveRecord::Base
  # before_create :set_default_multipliers
  before_create :init

  has_many :trips
  has_many :locations
  has_many :users_answers
  has_many :answers, through: :users_answers
  has_many :questions, through: :answers

  validates :email,
            format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create },
            presence: true,
            uniqueness: true
  has_secure_password

  def init
    self.weather_multiplier = 1.0
    self.safety_multiplier = 1.0
    self.dollars_multiplier = 1.0
    self.distance_multiplier = 1.0
  end

  def update_multipliers
    if !self.answers.empty?
      self.modify_weather_multiplier
      self.modify_safety_multiplier
      self.modify_distance_multiplier
      self.modify_dollars_multiplier
      self.save
    end
  end

  def modify_weather_multiplier
    # puts self.weather_multiplier
    weather_sum = self.answers.map{|answer| answer.weather_modifier}.reduce(:+)
    modification = 1 + weather_sum
    self.assign_attributes({weather_multiplier: modification.round(3)})
    # puts self.weather_multiplier
  end

  def modify_dollars_multiplier
    dollars_sum = self.answers.map{|answer| answer.dollars_modifier}.reduce(:+)
    modification = 1 + dollars_sum
    self.update_attributes(dollars_multiplier: modification.round(3))
  end

  def modify_distance_multiplier
    distance_sum = self.answers.map{|answer| answer.distance_modifier}.reduce(:+)
    modification = 1 + distance_sum
    self.update_attributes(distance_multiplier: modification.round(3))
  end

  def modify_safety_multiplier
    safety_sum = self.answers.map{|answer| answer.safety_modifier}.reduce(:+)
    modification = 1 + safety_sum
    self.update_attributes(safety_multiplier: modification.round(3))
  end

end
