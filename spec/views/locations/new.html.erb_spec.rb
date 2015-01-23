require 'rails_helper'

RSpec.describe "locations/new", :type => :view do
  before(:each) do
    assign(:location, Location.new(
      :address => "MyString",
      :name => "MyString",
      :lat => 1.5,
      :lng => 1.5
    ))
  end

  it "renders new location form" do
    render

    assert_select "form[action=?][method=?]", user_locations_path, "post" do

      assert_select "input#location_address[name=?]", "location[address]"

      assert_select "input#location_name[name=?]", "location[name]"

      assert_select "input#location_lat[name=?]", "location[lat]"

      assert_select "input#location_lng[name=?]", "location[lng]"
    end
  end
end
