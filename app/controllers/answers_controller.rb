class AnswersController < ApplicationController

  def create
    answer = Answer.find_by_content(params['commit'])
    UsersAnswer.create!(user: current_user, answer: answer)
    if answer.question.id < 7
      redirect_to user_question_path(user_id: current_user.id, id: answer.question.id + 1)
    else
      redirect_to root_path
    end
  end

end
