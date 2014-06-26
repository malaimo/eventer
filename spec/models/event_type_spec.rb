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

  it "should have a crm tag" do
    @event_type.tag_name = "TR-CP (Carlos Peix)"
    @event_type.valid?.should be true
  end

  context "for two events for a single event type" do

    before(:each) do
      @event1 = FactoryGirl.create(:event)
      @event2 = FactoryGirl.create(:event)

      @event1.event_type = @event_type
      @event2.event_type = @event_type
    end

    context "if they have participants" do

      before(:each) do
        @participant1 = FactoryGirl.build(:participant)
        @participant2 = FactoryGirl.build(:participant)
        @participant3 = FactoryGirl.build(:participant)

        @participant1.id = 101
        @participant2.id = 102
        @participant3.id = 103

        @participant1.status = "A"
        @participant2.status = "A"
        @participant3.status = "A"

        @participant1.event_rating = 5
        @participant2.event_rating = 5
        @participant3.event_rating = 2

        @participant1.promoter_score = 10
        @participant2.promoter_score = 9
        @participant3.promoter_score = 5

        @participant1.save!
        @participant2.save!
        @participant3.save!

        @event1.participants << @participant1
        @event1.participants << @participant2
        @event2.participants << @participant3

        @event1.save!
        @event2.save!
      end

      it "should have an average event rating" do
        @event_type.average_rating.should == 4
      end

      it "should have an average event rating even with participants without rating" do
        participant4 = FactoryGirl.build(:participant)
        participant4.id = 104
        participant4.status = "A"
        participant4.save!
        @event2.participants << participant4
        @event2.save!

        @event_type.average_rating.should == 4
      end

      it "should have an average event rating even with participants not being present" do
        participant4 = FactoryGirl.build(:participant)
        participant4.id = 104
        @participant3.event_rating = 5
        participant4.status = "C"
        participant4.save!
        @event2.participants << participant4
        @event2.save!

        @event_type.average_rating.should == 4
      end

      it "should have a net promoter score" do
        @event_type.net_promoter_score.should == 0.33
      end

      it "should have a net promoter score even with participants without rating" do
        participant4 = FactoryGirl.build(:participant)
        participant4.id = 104
        participant4.status = "A"
        participant4.save!
        @event2.participants << participant4
        @event2.save!

        @event_type.net_promoter_score.should == 0.33
      end

      it "should have a net promoter score even with participants not being present" do
        participant4 = FactoryGirl.build(:participant)
        participant4.id = 104
        @participant3.promoter_score = 0
        participant4.status = "C"
        participant4.save!
        @event2.participants << participant4
        @event2.save!

        @event_type.net_promoter_score.should == 0.33
      end

    end

  end
  
end
