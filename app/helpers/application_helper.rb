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
end
