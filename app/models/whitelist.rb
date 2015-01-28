class Whitelist < ActiveRecord::Base
  before_create :set_default
  belongs_to :user

  private
  def set_default
    self.walking = 1
    self.bicycling = 1
    self.divvy = 1
    self.bus = 1
    self.subway = 1
    self.uber = 1
    self.cab = 1
    self.driving = 1
  end
end
