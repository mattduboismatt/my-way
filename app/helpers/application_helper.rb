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
    case route.travel_mode

    when "bus", "subway"
      "comgooglemaps://?saddr=#{trip.origin.address}&daddr=#{trip.destination.address}&directionsmode=transit"
    when "walking"
      "comgooglemaps://?saddr=#{trip.origin.address}&daddr=#{trip.destination.address}&directionsmode=walking"
    when "driving"
      "comgooglemaps://?saddr=#{trip.origin.address}&daddr=#{trip.destination.address}&directionsmode=driving"
    when"uber"
      "uber://?action=setPickup&pickup=my_location&product_id=uberX"
    when 'bicycling', 'divvy'
      "comgooglemaps://?saddr=#{trip.origin.address}&daddr=#{trip.destination.address}&directionsmode=bicycling"
    when "cab"
     "uber://?action=setPickup&pickup=my_location&product_id=uberTAXI"
   end
 end

  def int_to_boolean?(int)
    if int == 1
      true
    else
      false
    end
  end
end
