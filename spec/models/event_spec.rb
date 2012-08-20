require 'spec_helper'

describe Event do
  
  before(:each) do
    @event = Factory.build(:event)
  end
  
  it "should be valid" do
    @event.valid?.should be true
  end
    
  it "should require its date" do
    @event.date = ""
    
    @event.valid?.should be false
  end
  
  it "should require its place" do
    @event.place = ""
    
    @event.valid?.should be false
  end
  
  it "should require its city" do
    @event.city = ""
    
    @event.valid?.should be false
  end
  
  it "should require its visibility_type" do
    @event.visibility_type = ""
    
    @event.valid?.should be false
  end
  
  it "should require its list_price" do
    @event.list_price = ""
    
    @event.valid?.should be false
  end
    
  it "should require its country" do
    @event.country = nil
    
    @event.valid?.should be false
  end
  
  it "should require its trainer" do
    @event.trainer = nil
    
    @event.valid?.should be false
  end
  
  it "should require its event_type" do
    @event.event_type = nil
    
    @event.valid?.should be false
  end
  
  it "should have a future date" do
      @event.date = "31/01/2000"

      @event.valid?.should be false
  end
  
  it "should have a capacity greater than 0" do
      @event.capacity = 0

      @event.valid?.should be false
  end
  
  it "Early Bird price should be smaller than List Price" do
      @event.list_price = 100
      @event.eb_price = 200
      
      @event.valid?.should be false
  end
  
  it "Early Bird date should be earlier than Event date" do
      @event.date = "31/01/3000"
      @event.eb_end_date = "31/01/3100"

      @event.valid?.should be false
  end
  
  it "A private event should not have discounts for 2 persons" do
       @event.visibility_type = "pr"
       @event.list_price_2_pax_discount = 10

       @event.valid?.should be false
   end
   
   it "A private event should not have discounts for 3+ persons" do
        @event.visibility_type = "pr"
        @event.list_price_3plus_pax_discount = 10

        @event.valid?.should be false
    end
    
    it "A public event can have discounts" do
         @event.visibility_type = 'pu'
         @event.list_price_2_pax_discount = 10
         @event.list_price_3plus_pax_discount = 15

         @event.valid?.should be true
     end
  
end
