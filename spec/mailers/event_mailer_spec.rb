require "spec_helper"

describe EventMailer do
  it "should queue and verify a simple email" do
  	participant = FactoryGirl.build(:participant)
  	participant.email = "carlos.peix@kleer.la"

  	email = EventMailer.welcome_new_event_participant(participant).deliver
  	
  	ActionMailer::Base.deliveries.empty?.should_not be true
  	email.to.should == ["carlos.peix@kleer.la"]
  end
end
