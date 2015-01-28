class Question < ActiveRecord::Base
  has_many :answers

  def next
    self.class.find_by(id: self[:id] + 1)
  end
end
