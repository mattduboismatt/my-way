require 'rails_helper'

RSpec.describe "locations/index", :type => :view do
  before(:each) do
    assign(:locations, [
      Location.create!(
        :address => "Address",
        :name => "Name",
        :lat => 1.5,
        :lng => 1.5
      ),
      Location.create!(
        :address => "Address",
        :name => "Name",
        :lat => 1.5,
        :lng => 1.5
      )
    ])
  end

  it "renders a list of locations" do
    render
    assert_select "tr>td", :text => "Address".to_s, :count => 2
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
  end
end