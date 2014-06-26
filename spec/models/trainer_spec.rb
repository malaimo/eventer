require 'spec_helper'

describe Trainer do
  it "should require a name" do
    t = FactoryGirl.build(:trainer)
    
    t.name = ""

    t.valid?.should be false
  end

	it "should let me set a bio" do
		t = FactoryGirl.build(:trainer)

		t.bio = "Mini bio"

    t.valid?.should be true
	end
	
	it "should let me set a gravatar e-mail" do
    t = FactoryGirl.build(:trainer)

		t.gravatar_email = "malaimo@gmail.com"

    t.valid?.should be true
  end
  
  it "should let me set a twittwr username" do
    t = FactoryGirl.build(:trainer)

		t.twitter_username = "martinalaimo"

    t.valid?.should be true
  end
  
  it "should let me set a linkein url" do
    t = FactoryGirl.build(:trainer)

		t.linkedin_url = "http://ar.linkedin.com/in/malaimo"

    t.valid?.should be true
  end  

  it "should let me indicate if the trainer is a kleerer" do
    t = FactoryGirl.build(:trainer)

		t.is_kleerer = true

    t.valid?.should be true
  end
  
  it "should calculate the gravatar for malaimo e-mail" do
    t = FactoryGirl.build(:trainer)

		t.gravatar_email = "malaimo@gmail.com"

    t.gravatar_picture_url.should == "http://www.gravatar.com/avatar/e92b3ae0ce91e1baf19a7bc62ac03297"
  end
  
  it "should calculate the gravatar for jgabardini e-mail" do
    t = FactoryGirl.build(:trainer)

		t.gravatar_email = "jgabardini@computer.org"

    t.gravatar_picture_url.should == "http://www.gravatar.com/avatar/72c191f31437b3250822b38d5f57705b"
  end
  
  it "should handle a nil gravatar e-mail" do
    t = FactoryGirl.build(:trainer)

		t.gravatar_email = nil

    t.gravatar_picture_url.should == "http://www.gravatar.com/avatar/asljasld"
  end

  it "should have a crm tag" do
    t = FactoryGirl.build(:trainer)

    t.tag_name = "TR-CP (Carlos Peix)"

    t.valid?.should be true
  end

  context "for two events for a single trainer type" do

    before(:each) do
      @trainer = FactoryGirl.create(:trainer)

      @event1 = FactoryGirl.create(:event)
      @event2 = FactoryGirl.create(:event)

      @event1.trainer = @trainer
      @event2.trainer = @trainer

      @event1.save!
      @event2.save!
    end

    context "if both of them have participants" do

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

        @participant1.trainer_rating = 5
        @participant2.trainer_rating = 5
        @participant3.trainer_rating = 2

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

      it "should have an average trainer rating" do
        @trainer.average_rating.should == 4
      end

      it "should have a global trainer rating" do
        Participant.average("trainer_rating").should == 4
      end

      it "should have an average event rating even with participants without rating" do
        participant4 = FactoryGirl.build(:participant)
        participant4.id = 104
        participant4.status = "A"
        participant4.save!
        @event2.participants << participant4
        @event2.save!

        @trainer.average_rating.should == 4
      end

      it "should have an average event rating even with participants not being present" do
        participant4 = FactoryGirl.build(:participant)
        participant4.id = 104
        @participant3.event_rating = 5
        participant4.status = "C"
        participant4.save!
        @event2.participants << participant4
        @event2.save!

        @trainer.average_rating.should == 4
      end

      it "should have a net promoter score" do
        @trainer.net_promoter_score.should == 0.33
      end

      it "should have a net promoter score even with participants without rating" do
        participant4 = FactoryGirl.build(:participant)
        participant4.id = 104
        participant4.status = "A"
        participant4.save!
        @event2.participants << participant4
        @event2.save!

        @trainer.net_promoter_score.should == 0.33
      end

      it "should have a net promoter score even with participants not being present" do
        participant4 = FactoryGirl.build(:participant)
        participant4.id = 104
        @participant3.promoter_score = 0
        participant4.status = "C"
        participant4.save!
        @event2.participants << participant4
        @event2.save!

        @trainer.net_promoter_score.should == 0.33
      end

    end

  end

end
