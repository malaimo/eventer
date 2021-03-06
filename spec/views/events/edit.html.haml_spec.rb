require 'spec_helper'

describe "events/edit" do
  before(:each) do
    @countries = Country.all
    @trainers = Trainer.all
    @event = assign(:event, stub_model(Event,
      :name => "MyString",
      :place => "MyString",
      :capacity => 1,
      :city => "MyString",
      :country => Factory.build(:country),
      :trainer => Factory.build(:trainer),
      :type => "",
      :list_price => "9.99",
      :list_price_plus_tax => false,
      :list_price_2_pax_discount => 1,
      :list_price_3plus_pax_discount => 1,
      :seb_price => "9.99",
      :eb_price => "9.99",
      :description => "MyText",
      :recipients => "MyText",
      :program => "MyText",
      :draft => false,
      :cancelled => false
    ))
  end

  it "renders the edit event form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => events_path(@event), :method => "post" do
      assert_select "input#event_name", :name => "event[name]"
      assert_select "input#event_place", :name => "event[place]"
      assert_select "input#event_capacity", :name => "event[capacity]"
      assert_select "input#event_city", :name => "event[city]"
      assert_select "select#event_country_id", :name => "event[country_id]"
      assert_select "select#event_trainer_id", :name => "event[trainer_id]"
      assert_select "input#event_visibility_type_pr", :name => "event[visibility_type]"
      assert_select "input#event_visibility_type_pu", :name => "event[visibility_type]"
      assert_select "input#event_list_price", :name => "event[list_price]"
      assert_select "input#event_list_price_plus_tax", :name => "event[list_price_plus_tax]"
      assert_select "input#event_list_price_2_pax_discount", :name => "event[list_price_2_pax_discount]"
      assert_select "input#event_list_price_3plus_pax_discount", :name => "event[list_price_3plus_pax_discount]"
      assert_select "input#event_seb_price", :name => "event[seb_price]"
      assert_select "input#event_eb_price", :name => "event[eb_price]"
      assert_select "textarea#event_description", :name => "event[description]"
      assert_select "textarea#event_recipients", :name => "event[recipients]"
      assert_select "textarea#event_program", :name => "event[program]"
      assert_select "input#event_draft", :name => "event[draft]"
      assert_select "input#event_cancelled", :name => "event[cancelled]"
    end
  end
end
