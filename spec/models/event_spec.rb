require 'spec_helper'

describe Event do

  before(:each) do
    @event = FactoryGirl.build(:event)
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

     it "It should return a completion percentage" do

          @event.capacity = 10

          p = Participant.new({:fname => "juan", :lname => "pipo", :phone => "1234-5678", :email => "ppp@ppp.com"})
          p.event = @event
          p.status = "C"
          p.save

          @event.completion.should == 0.1
      end

     it "It should compute weeks from now" do
          today = Date.today
          @event.date = today

          @event.weeks_from(today.weeks_ago(3)).should == 3
      end

     it "It should compute weeks from now (next year)" do
          today = Date.today
          @event.date = today.years_since(1)

          @event.weeks_from(today).should == 52
      end
      
  it "should require a duration" do
    @event.duration = ""

    @event.valid?.should be false
  end

  it "should have a duration greater than 0" do
      @event.duration = 0

      @event.valid?.should be false
  end  
  
  it "should require a start time" do
    @event.start_time = ""

    @event.valid?.should be false
  end
  
  it "should require a end time" do
    @event.end_time = ""

    @event.valid?.should be false
  end
  
  context "if event date is 15-Jan-2015" do
    
    before (:each) do
      @event.date = "15/01/2015"
    end
    
    it "should have a human date in spanish that returns '15 Ene' if duration is 1" do
      @event.duration = 1
      @event.human_date.should == "15 Ene"
    end
    
    it "should have a human date in spanish that returns '15-16 Ene' if duration is 2" do
      @event.duration = 2
      @event.human_date.should == "15-16 Ene" 
    end
    
    it "should have a human date in spanish that returns '15 Ene-14 Feb' if duration is 31" do
      @event.duration = 31
      @event.human_date.should ==  "15 Ene-14 Feb"
    end
  end
  
  context "if event date is 20-Apr-2015" do
    
    before (:each) do
      @event.date = "20/04/2015"
    end
    
    it "should have a human date in spanish that returns '20 Abr' if duration is 1" do
      @event.duration = 1
      @event.human_date.should == "20 Abr"
    end
    
    it "should have a human date in spanish that returns '20-22 Abr' if duration is 3" do
      @event.duration = 3
      @event.human_date.should == "20-22 Abr" 
    end
    
    it "should have a human date in spanish that returns '20 Abr-04 May' if duration is 15" do
      @event.duration = 15
      @event.human_date.should ==  "20 Abr-4 May"
    end
  end
end
