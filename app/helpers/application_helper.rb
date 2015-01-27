module ApplicationHelper
  def method_limiter(routes)
    display_routes = []
    display_routes << routes[0]
    routes.each do |route|
      if display_routes.any?{|r| r.travel_mode != route.travel_mode}
        display_routes << route
      end
    end
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

end
