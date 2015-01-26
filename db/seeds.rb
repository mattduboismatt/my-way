require 'csv'
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

CSV.foreach('./doc/cta_L_stops.csv',{headers:true, :header_converters => :symbol}) {|row| CtaTrainStop.create!(row.to_hash)}

def create_stations
  divvy_data = Divvy.response
  divvy_data['stationBeanList'].each do |station|
    station_data = Divvy.key_map(station)
    Divvy.create!(station_data)
  end
end
create_stations

questions_contents = ["How do you feel about Black Friday?", "I go to the beach...", "If I went to a theme park, I would wait in line for...", "When I go to the grocery store I...", "The majority of shoes I own are...", "When my alarm clock goes off I...", "I currently live..."]

questions_contents.each do |text|
  Question.create(content: text)
end

def make_answers(answer_array, question_number)
  answer_array.each do |answer|
    Answer.create(question_id: question_number, content: answer, weather_modifier: 1.0, dollars_modifier: 1.0, distance_modifier: 1.0, duration_modifier: 1.0)
  end
end

question_1_answers = ["I participate every year!",
  "It is usually too cold to wait in line.",
  "You can't pay me any amount too stand in line.",
  "It is just another friday."]

question_2_answers = [ "Every summer, no matter what!",
 "Only if I have to.",
 "If the weather cooperates.",
 "Everyday, because I live in a beachside condo."]

question_3_answers = [ "as long as it takes!",
"What? I just buy the express pass that lets me skip them.",
"an hour at most.",
"I don't go to theme parks."]

question_4_answers = [ "buy major brands.",
"buy store brands. They're all the same.",
"I rarely go to grocery stores, I just eat out.",
"just buy fruits and vegetables."]

question_5_answers = [  "dress shoes.",
"running shoes.",
"casual shoes.",
"I only own one pair of gym shoes."]

question_6_answers = [   "immediately get out of bed.",
"I hit the snooze, then get out of bed on the next alarm.",
"I hit the snooze; I have 5 alarms set anyway.",
"I do not use an alarm."]

question_7_answers = [   "in a small neighborhood.",
 "on a busy street.",
 "in the heart of the city (downtown).",
 "in the suburbs."]

 $answers_array = [question_1_answers, question_2_answers, question_3_answers, question_4_answers, question_5_answers, question_6_answers, question_7_answers]

questions_contents.each_with_index do |content, index|
  make_answers($answers_array[index], index+1)
end







# Question.create(content: "apple jacks")
# Question.create(content: "jack apples")
# Answer.create(question_id: 2, content: "yes", weather_modifier: 2.0, dollars_modifier: 1.5, distance_modifier: 1.0, duration_modifier: 0.5)
# UsersAnswer.create(answer_id: 1, user_id: 1)
# UsersAnswer.create(answer_id: 2, user_id: 1)
