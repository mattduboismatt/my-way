require_relative './divvy.rb'
divvy_uri = DivvyParser.build_uri
divvy_res = Net::HTTP.get(divvy_uri)
DivvyParser.update_divvy(divvy_res)
