class Location < ActiveRecord::Base
  belongs_to :user
  belongs_to :trip
  after_initialize :format_address

  def format_address
    address = self.address.downcase
    if !address.include?("chicago")
      address = address + " chicago il"
    end
    self.address = address.gsub(",", " ")
  end
end
