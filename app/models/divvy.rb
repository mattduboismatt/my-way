class Divvy < ActiveRecord::Base
  include DivvyParser

  def self.divvy_res
    divvy_uri = DivvyParser.build_uri
    Net::HTTP.get(divvy_uri)
  end

  def self.update
    Divvy.divvy_res["stationBeanLis"].each do |station|
      Divvy.new(station)
    end
  end


end
