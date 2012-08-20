require 'spec_helper'

describe "event_types/edit" do
  before(:each) do
    @event_type = assign(:event_type, stub_model(EventType,
      :name => "MyString",
      :description => "MyText",
      :recipients => "MyText",
      :program => "MyText"
    ))
  end

  it "renders the edit event_type form" do
    render
    assert_select "form", :action => event_types_path(@event_type), :method => "post" do
      assert_select "input#event_type_name", :name => "event_type[name]"
      assert_select "textarea#event_type_description", :name => "event_type[description]"
      assert_select "textarea#event_type_recipients", :name => "event_type[recipients]"
      assert_select "textarea#event_type_program", :name => "event_type[program]"
    end
  end
end
