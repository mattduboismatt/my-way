class Location < ActiveRecord::Base
  belongs_to :user
  belongs_to :trip
  after_initialize :format_address

  def format_address
    if self.address
      address = self.address.downcase
      if !address.include?("chicago")
        address = address + " chicago il"
      end
      self.address = address.gsub(/\W/, " ")
    end
  end
end
