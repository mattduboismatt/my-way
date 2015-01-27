module ApplicationHelper
  def method_limiter(routes)
    display_routes =  routes.uniq{|r| r.travel_mode}
    display_routes
  end

  def sym_placer(r)
    case r.travel_mode
    when "bus"
      "fa fa-bus"
    when "subway"
      "fa fa-train"
    when "walking"
      "fa fa-male"
    when "driving", "uber"
      "fa fa-car"
    when 'bicycling', 'divvy'
      "fa fa-bicycle"
    when "cab"
      "fa fa-taxi"
    end
  end

  def app_link(trip,route)
    # case r.travel_mode
    # when "bus"
    #   "fa fa-bus"
    # when "subway"
    #   "fa fa-train"
    # when "walking"
    #   "fa fa-male"
    # when "driving", "uber"
    #   "fa fa-car"
    # when 'bicycling', 'divvy'
    #   "fa fa-bicycle"
    # when "cab"
    #   "fa fa-taxi"
    # end
    "comgooglemaps://?saddr=#{trip.origin.address}&daddr#{trip.destination.address}&directionsmode:driving"
  end

end
