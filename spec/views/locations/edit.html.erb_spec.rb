# require 'rails_helper'

# RSpec.describe "locations/edit", :type => :view do
#   before(:each) do
#     @location = assign(:location, Location.create!(
#       :address => "MyString",
#       :name => "MyString",
#       :lat => 1.5,
#       :lng => 1.5
#     ))
#   end

#   it "renders the edit location form" do
#     render

#     assert_select "form[action=?][method=?]", location_path(@location), "post" do

#       assert_select "input#location_address[name=?]", "location[address]"

#       assert_select "input#location_name[name=?]", "location[name]"

#       assert_select "input#location_lat[name=?]", "location[lat]"

#       assert_select "input#location_lng[name=?]", "location[lng]"
#     end
#   end
# end
