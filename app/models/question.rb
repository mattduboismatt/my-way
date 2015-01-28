class Question < ActiveRecord::Base
  has_many :answers
  has_many :users_answers, through: :answers

  def next
    self.class.find_by(id: self[:id] + 1)
  end

  def answer_for(user)
    self.answers.joins(:users_answers).find_by(users_answers: {user: user})
  end
end
