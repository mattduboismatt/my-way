class Trip < ActiveRecord::Base
  belongs_to :user
  has_one :origin, class_name: 'Location'
  has_one :destination, class_name: 'Location'
  has_many :routes
end
