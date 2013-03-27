require 'spec_helper'

describe Participant do
  
  before(:each) do
    @participant = FactoryGirl.build(:participant)
  end
  
  it "should be valid" do
    @participant.valid?.should be true
  end
  
  it "should have a default status of 'N'" do
    @participant.status.should == "N"
  end
  
  it "should require its name" do
    @participant.fname = ""
    
    @participant.valid?.should be false
  end
  
  it "should require its last name" do
    @participant.lname = ""
    
    @participant.valid?.should be false
  end
  
  it "should require its email" do
    @participant.email = ""
    
    @participant.valid?.should be false
  end
  
  it "should validate the email" do
    @participant.email = "cualquiercosa"
    
    @participant.valid?.should be false
  end

  it "should validate the email" do
    @participant.email = "hola@gmail.com"
    
    @participant.valid?.should be true
  end  
  
  it "should require its phone" do
    @participant.phone = ""
    
    @participant.valid?.should be false
  end
  
end
