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
    weather_sum = self.answers.map{|a| a.weather_modifier}.reduce(:+)
    mod = 1 + weather_sum
    if mod < 0.2
      mod = 0.2
    end
    self.weather_multiplier = mod.round(3)
  end

  def modify_dollars_multiplier
    dollars_sum = self.answers.map{|a| a.dollars_modifier}.reduce(:+)
    mod = 1 + dollars_sum
    if mod < 0.2
      mod = 0.2
    end
    self.dollars_multiplier = mod.round(3)
  end

  def modify_distance_multiplier
    distance_sum = self.answers.map{|a| a.distance_modifier}.reduce(:+)
    mod = 1 + distance_sum
    if mod < 0.2
      mod = 0.2
    end
    self.distance_multiplier = mod.round(3)
  end

  def modify_safety_multiplier
    safety_sum = self.answers.map{|a| a.safety_modifier}.reduce(:+)
    mod = 1 + safety_sum
    if mod < 0.2
      mod = 0.2
    end
    self.safety_multiplier = mod.round(3)
  end

end
