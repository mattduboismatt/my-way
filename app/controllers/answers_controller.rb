class AnswersController < ApplicationController
  respond_to :html, :json

  def create
    answer = Answer.find_by_content(params['content'])
    UsersAnswer.create(user: current_user, answer: answer)
    if answer.question.id < Question.last.id
      respond_to do |format|
        @question = Question.find((answer.question.id+1))
        format.html { redirect_to user_question_path(current_user, @question) }
        format.json { render "questions/show" }
      end
    else
      # respond_to do |format|
        # format.html { redirect_to root_path }
        # format.json { render :js => "window.location = '/'" }
        render :js => "window.location = '/'"
      # end
    end
  end
end
