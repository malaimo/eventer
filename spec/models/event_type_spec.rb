require 'spec_helper'

describe EventType do
  
  it { should have_and_belong_to_many(:trainers) }
  it { should have_and_belong_to_many(:categories) }
  
  before(:each) do
    @event_type = FactoryGirl.build(:event_type)
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
  
  it "should require an elevator pitch" do
    @event_type.elevator_pitch = ""
    
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
  
  it "should have a shot_name version returning 30 characters if name is longer" do
    @event_type.name = "qoweiuq owei owqieu qoiweuqo iweu qwoeu qouwie qowieuq woiequ woei uqowie"
    @event_type.short_name.should == "qoweiuq owei owqieu qoiweuqo i..."
  end 
  
  it "should have a shot_name version returning all characters if name is shorter than 30 letters" do
    @event_type.name = "hola che!"
    @event_type.short_name.should == "hola che!"
  end 
  
end
