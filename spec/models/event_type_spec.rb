require 'spec_helper'

describe EventType do
  
  it { should have_and_belong_to_many(:trainers) }
  
  before(:each) do
    @event_type = Factory.build(:event_type)
  end
  
  it "should be valid" do
    @event_type.valid?.should be true
  end
  
  it "should require its name" do
    @event_type.name = ""
    
    @event_type.valid?.should be false
  end
  
  it "should require its description" do
    @event_type.description = ""
    
    @event_type.valid?.should be false
  end
  
  it "should require its recipients" do
    @event_type.recipients = ""
    
    @event_type.valid?.should be false
  end
  
  it "should require its program" do
    @event_type.program = ""
    
    @event_type.valid?.should be false
  end
  
  it "should require its duration" do
    @event_type.duration = ""
    
    @event_type.valid?.should be false
  end
  
end
