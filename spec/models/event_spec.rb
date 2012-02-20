require 'spec_helper'

describe Event do
  
  before(:each) do
    @event = Factory.build(:event)
  end
  
  it "should be valid" do
    @event.valid?.should be true
  end
  
  it "should require its name" do
    @event.name = ""
    
    @event.valid?.should be false
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
  
  it "should require its description" do
    @event.description = ""
    
    @event.valid?.should be false
  end
  
  it "should require its recipients" do
    @event.recipients = ""
    
    @event.valid?.should be false
  end
  
  it "should require its program" do
    @event.program = ""
    
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
  
  it "should have a future date" do
      @event.date = "31/01/2000"

      @event.valid?.should be false
  end
  
  it "should have a capacity greater than 0" do
      @event.capacity = 0

      @event.valid?.should be false
  end
  
  it "Super Early Bird price should be smaller than List Price" do
      @event.list_price = 100
      @event.seb_price = 200

      @event.valid?.should be false
  end
  
  it "Super Early Bird price should be smaller than Early Bird Price" do
      @event.eb_price = 100
      @event.seb_price = 200

      @event.valid?.should be false
  end
  
  it "Early Bird price should be smaller than List Price" do
      @event.list_price = 100
      @event.eb_price = 200
      
      @event.valid?.should be false
  end
  
  it "Super Early Bird date should be earlier than Event date" do
      @event.date = "31/01/3000"
      @event.seb_end_date = "31/01/3100"

      @event.valid?.should be false
  end
  
  it "Early Bird date should be earlier than Event date" do
      @event.date = "31/01/3000"
      @event.eb_end_date = "31/01/3100"

      @event.valid?.should be false
  end
  
  it "Super Early Bird date should be earlier than Early Bird date" do
      @event.date = "31/01/4000"
      @event.seb_end_date = "31/01/3100"
      @event.eb_end_date = "31/01/3000"
      
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
