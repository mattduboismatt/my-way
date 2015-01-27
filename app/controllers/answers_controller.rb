class AnswersController < ApplicationController

  def create
    answer = Answer.find_by_content(params['commit'])
    UsersAnswer.create!(user: current_user, answer: answer)
  end

end
