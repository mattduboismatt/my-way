class AnswersController < ApplicationController
  respond_to :html, :json

  def create
    answer = Answer.find_by_content(params['content'])
    UsersAnswer.create!(user: current_user, answer: answer)
    # binding.pry
    if answer.question.id < 7
      # if request.xhr?
      @question = Question.find((answer.question.id+1))
      # @question.
      # binding.pry
      @question.to_json
      # else
      #   redirect_to user_question_path(user_id: current_user.id, id: answer.question.id + 1)
      # end
    else
      redirect_to root_path
    end
  end
end
