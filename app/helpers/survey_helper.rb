module SurveyHelper

  def selected_answer(answer, user)
    answer.users.include?(user) ? 'selected-answer' : 'answer'
  end

end
