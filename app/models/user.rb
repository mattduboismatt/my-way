class User < ActiveRecord::Base
  has_many :locations

  validates :email,
            format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create },
            presence: true,
            uniqueness: true
  validates :age,
            numericality: true,
            inclusion: {in:16..120}
  validates :password,
            confirmation: true,
            presence: true
  validates :username,
            uniqueness: true,
            presence: true
  has_secure_password



end
