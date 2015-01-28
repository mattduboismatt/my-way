class User < ActiveRecord::Base
  # before_create :set_default_multipliers
  before_create :init
  after_create :create_whitelist

  has_many :trips
  has_many :locations
  has_many :users_answers
  has_many :answers, through: :users_answers
  has_many :questions, through: :answers
  has_one :whitelist

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

  def create_whitelist
    Whitelist.create(user: self)
  end

  def update_whitelist(whitelist_data)
    wl = Whitelist.find_or_create_by(user: self)
    wl.update_attributes(whitelist_data.to_hash)
  end

  def update_multipliers
    if self.answers.present?
      [:weather, :safety, :distance, :dollars].map do |f|
        self.modify_multiplier(f)
      end
      self.save
    end
  end

  def modify_multiplier(field)
    field = "#{field}_modifier"
    sum = self.answers.map { |a| a.send(field) }.reduce(:+)
    mod = [0.2, 1 + sum].max
    self.send(:"#{field}=", mod.round(3))
  end
end
