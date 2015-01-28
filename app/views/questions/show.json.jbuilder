json.question @question
json.question_path question_url(@question)
json.question_html render(partial: "questions/prompt", formats: [:html])
