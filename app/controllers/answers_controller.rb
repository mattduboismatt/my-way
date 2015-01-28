class AnswersController < ApplicationController
  respond_to :html, :json

  def create
    question = Question.find(params[:question_id])
    p question
    add_answer(question, params[:content])
    if @question = question.next
      respond_to do |format|
        format.html { redirect_to question_path(@question) }
        format.json { render "questions/show" }
      end
    else
      respond_to do |format|
        format.html { redirect_to root_path }
        format.json { head :created, location: root_path }
      end
    end
  end

  def add_answer(question, content)
    answer = question.answers.find_by(content: content)
    question.users_answers.where(user: current_user).destroy_all
    current_user.answers << answer
    answer
  end
end
