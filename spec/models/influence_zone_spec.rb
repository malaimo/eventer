require 'spec_helper'

describe InfluenceZone do
  
  before(:each) do
    @zi = FactoryGirl.build(:influence_zone)
  end
  
    it "should be valid" do
      @zi.valid?.should be true
    end

    it "should not require its zone name" do
      @zi.zone_name = ""

      @zi.valid?.should be true
    end

    it "should require its tag name" do
      @zi.tag_name = ""

      @zi.valid?.should be false
    end

    it "should require its country" do
      @zi.country = nil

      @zi.valid?.should be false
    end
    
    context "for Argentina" do
      
      before(:each) do
        @zi.country = FactoryGirl.build(:country)
      end
    
      it "display_name should be 'Argentina' if zone_name = ''" do
        @zi.zone_name = ""
        
        @zi.display_name.should == "Argentina"
      end
    
      it "display_name should be 'Argentina - Buenos Aires' if zone_name = 'Buenos Aires'" do
        @zi.zone_name = "Buenos Aires"
        
        @zi.display_name.should == "Argentina - Buenos Aires"
      end
    
    end
  
end
