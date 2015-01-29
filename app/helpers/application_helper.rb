module ApplicationHelper
  def method_limiter(routes)
    display_routes =  routes.uniq{|r| r.travel_mode}
    display_routes
  end

  def select_image
    return "my-way-no-border.png" if current_page? '/chicago'
    return "my-way-backwards.png"
  end

  def render_header
    @question ? true:false
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
      "uber://?action=setPickup&pickup=my_location&product_id=4bfc6c57-98c0-424f-a72e-c1e2a1d49939"
    when 'bicycling', 'divvy'
      "comgooglemaps://?saddr=#{trip.origin.address}&daddr=#{trip.destination.address}&directionsmode=bicycling"
    when "cab"
     "uber://?action=setPickup&pickup=my_location&product_id=f2277fbc-e4fb-4bc5-9f1a-9c4d91ad2354"
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
