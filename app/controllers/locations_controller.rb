class LocationsController < ApplicationController
  def street_address_from_lat_long
    lat = params[:coords][:latitude].to_f
    lng = params[:coords][:longitude].to_f
    geocode = Geocoder.search("#{lat}, #{lng}")
    respond_to do |format|
        format.html { redirect_to root_path }
        format.json { render json: { street_address: geocode[0].address } }
    end
  end
end
