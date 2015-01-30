require 'csv'


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

Answer.create(question_id: 1, content: "I participate every year!",                      distance_modifier: -0.05, dollars_modifier: 0.1, weather_modifier: -0.05, safety_modifier: -0.1)
Answer.create(question_id: 1, content: "It's usually too cold to wait in line.",        distance_modifier: 0.01, dollars_modifier: -0.01, weather_modifier: 0.15, safety_modifier: 0.05)
Answer.create(question_id: 1, content: "You can't pay me enough to stand in line.", distance_modifier: 0.05, dollars_modifier: -0.1, weather_modifier: 0.05, safety_modifier: 0.1)
Answer.create(question_id: 1, content: "It's just another friday.",                      distance_modifier: 0.05, dollars_modifier: -0.05, weather_modifier: -0.02, safety_modifier: -0.02)

Answer.create(question_id: 2, content: "Every summer, no matter what!",                  distance_modifier: -0.05, dollars_modifier: -0.03, weather_modifier: -0.1, safety_modifier: -0.03)
Answer.create(question_id: 2, content: "Only if I have to.",                             distance_modifier: 0.05, dollars_modifier: 2.0, weather_modifier: 0.03, safety_modifier: 0.01)
Answer.create(question_id: 2, content: "If the weather cooperates.",                     distance_modifier: -0.05, dollars_modifier: 0.01, weather_modifier: 0.05, safety_modifier: 0.03)
Answer.create(question_id: 2, content: "Everyday! I live in a beachside condo.", distance_modifier: 0.05, dollars_modifier: -0.1, weather_modifier: -0.05, safety_modifier: -0.05)

Answer.create(question_id: 3, content: "as long as it takes!",                                      distance_modifier: -0.05, dollars_modifier: -0.05, weather_modifier: -0.05, safety_modifier: -0.02)
Answer.create(question_id: 3, content: "I just buy an express pass.", distance_modifier: -0.05, dollars_modifier: -0.08, weather_modifier: 0.02, safety_modifier: -0.01)
Answer.create(question_id: 3, content: "an hour at most.",                                          distance_modifier: -0.05, dollars_modifier: 0.05, weather_modifier: 0.01, safety_modifier: 0.01)
Answer.create(question_id: 3, content: "I don't go to theme parks.",                                distance_modifier: 0.1, dollars_modifier: 0.05, weather_modifier: 0.03, safety_modifier: 0.05)

Answer.create(question_id: 4, content: "buy major brands.",                              distance_modifier: -0.05, dollars_modifier: -0.1, weather_modifier: 0.01, safety_modifier: -0.02)
Answer.create(question_id: 4, content: "buy store brands. They're all the same.",        distance_modifier: -0.05, dollars_modifier: 0.05, weather_modifier: 0.01, safety_modifier: 0.02)
Answer.create(question_id: 4, content: "I rarely shop, I just eat out.", distance_modifier: 0.1, dollars_modifier: -0.2, weather_modifier: -0.08, safety_modifier: 0.03)
Answer.create(question_id: 4, content: "just buy fruits and vegetables.",                distance_modifier: -0.05, dollars_modifier: 0.05, weather_modifier: 0.01, safety_modifier: 0.03)

Answer.create(question_id: 5, content: "dress shoes.",                      distance_modifier: 0.15, dollars_modifier: -0.1, weather_modifier: 0.05, safety_modifier: 0.07)
Answer.create(question_id: 5, content: "running shoes.",                    distance_modifier: -0.1, dollars_modifier: -0.07, weather_modifier: -0.08, safety_modifier: -0.03)
Answer.create(question_id: 5, content: "casual shoes.",                     distance_modifier: -0.02, dollars_modifier: -0.05, weather_modifier: 0.01, safety_modifier: 0.02)
Answer.create(question_id: 5, content: "I only own one pair of gym shoes.", distance_modifier: -0.05, dollars_modifier: 0.1, weather_modifier: -0.05, safety_modifier: -0.02)

Answer.create(question_id: 6, content: "immediately get out of bed.",                              distance_modifier: 0.06, dollars_modifier: 0.15, weather_modifier: 0.07, safety_modifier: 0.05)
Answer.create(question_id: 6, content: "I hit snooze and get up on the next alarm.", distance_modifier: 0.03, dollars_modifier: 0.05, weather_modifier: 0.035, safety_modifier: 0.025)
Answer.create(question_id: 6, content: "I hit snooze; I have 5 alarms set anyway.",            distance_modifier: -0.02, dollars_modifier: -0.05, weather_modifier: -0.02, safety_modifier: 0.1)
Answer.create(question_id: 6, content: "I do not use an alarm.",                                    distance_modifier: -0.8, dollars_modifier: -0.1, weather_modifier: -0.06, safety_modifier: -0.1)

Answer.create(question_id: 7, content: "in a small neighborhood.",             distance_modifier: -0.1, dollars_modifier: 0.01, weather_modifier: -0.01, safety_modifier: 0.05)
Answer.create(question_id: 7, content: "on a busy street.",                    distance_modifier: 0.05, dollars_modifier: -0.01, weather_modifier: 0.06, safety_modifier: -0.01)
Answer.create(question_id: 7, content: "in the heart of the city (downtown).", distance_modifier: 0.01, dollars_modifier: 0.05, weather_modifier: 0.1, safety_modifier: -0.06)
Answer.create(question_id: 7, content: "in the suburbs.",                      distance_modifier: 0.07, dollars_modifier: 0.05, weather_modifier: -0.1, safety_modifier: 0.05)
