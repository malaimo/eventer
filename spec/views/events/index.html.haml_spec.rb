# encoding: utf-8

require 'spec_helper'

describe "events/index" do
  before(:each) do
    assign(:events, [
      stub_model(Event,
        :name => "Evento 1",
        :place => "Place",
        :date => "2015-01-01",
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
        :draft => true,
        :cancelled => false
      ),
      stub_model(Event,
        :name => "Evento 2",
        :place => "Place",
        :date => "2015-01-01",
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
    assert_select "tr>th", :text => "Fecha".to_s, :count => 1
    assert_select "tr>th", :text => "Nombre".to_s, :count => 1
    assert_select "tr>th", :text => "Ciudad".to_s, :count => 1
    assert_select "tr>th", :text => "País".to_s, :count => 1
    assert_select "tr>th", :text => "Tipo".to_s, :count => 1
    assert_select "tr>th", :text => "Acciones".to_s, :count => 1
    assert_select "tr>td", :text => "Evento 1".to_s, :count => 1
    assert_select "tr>td", :text => "Evento 2".to_s, :count => 1
    assert_select "tr>td", :text => "2015-01-01".to_s, :count => 2
  end
end
