class Trip < ActiveRecord::Base
  belongs_to :user
  has_many :locations
  has_one :origin, through: :locations
  has_one :destination, through: :locations
end
