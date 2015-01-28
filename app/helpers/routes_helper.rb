module RoutesHelper

  def suggestion(routes)
    travel_mode = routes.first.travel_mode
    travel_mode = 'bike' if travel_mode == 'bicycling'
    travel_mode = 'walk' if travel_mode == 'walking'
    travel_mode = 'drive' if travel_mode == 'driving'
    travel_mode = 'take a cab' if travel_mode == 'cab'
    travel_mode = 'take a bus' if travel_mode == 'bus'
    "You Should #{travel_mode.capitalize} Today"
  end


  def dollar_converter(r)
    number_to_currency(r.actual_cost) == '$0.00' ? 'Free' : number_to_currency(r.actual_cost)
  end

  def duration(r)
    (r.duration/60).to_i
  end

  def travel_mode(r)
    r.travel_mode
  end


  def color_selector(r)
    score = r.weighted_exp
    return ['teal', 'blue'].sample if score > 250
    return 'orange' if score > 125
    return 'red'
  end




end
