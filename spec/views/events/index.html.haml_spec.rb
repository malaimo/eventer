require 'spec_helper'

describe "events/index" do
  before(:each) do
    assign(:events, [
      stub_model(Event,
        :name => "Name",
        :place => "Place",
        :capacity => 20,
        :city => "City",
        :country => Factory.build(:country),
        :trainer => Factory.build(:trainer),
        :visibility_type => "Type",
        :list_price => "9.99",
        :list_price_plus_tax => false,
        :list_price_2_pax_discount => 15,
        :list_price_3plus_pax_discount => 25,
        :seb_price => "9.99",
        :eb_price => "19.99",
        :description => "MyText-Description",
        :recipients => "MyText-Recipients",
        :program => "MyText-Program",
        :draft => false,
        :cancelled => false
      ),
      stub_model(Event,
        :name => "Name",
        :place => "Place",
        :capacity => 20,
        :city => "City",
        :country => Factory.build(:country),
        :trainer => Factory.build(:trainer),
        :visibility_type => "Type",
        :list_price => "9.99",
        :list_price_plus_tax => false,
        :list_price_2_pax_discount => 15,
        :list_price_3plus_pax_discount => 25,
        :seb_price => "9.99",
        :eb_price => "19.99",
        :description => "MyText-Description",
        :recipients => "MyText-Recipients",
        :program => "MyText-Program",
        :draft => false,
        :cancelled => false
      )
    ])
  end

  it "renders a list of events" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Place".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 20.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "City".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => Factory.build(:country).name, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => Factory.build(:trainer).name, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Type".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "9.99".to_s, :count => 4
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 15.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 25.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "19.99".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "MyText-Description".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "MyText-Recipients".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "MyText-Program".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => false.to_s, :count => 6
  end
end
