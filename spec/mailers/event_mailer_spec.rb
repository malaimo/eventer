
require "spec_helper"
describe EventMailer do
  it "should queue and verify a simple email" do
    participant = FactoryGirl.build(:participant)
    participant.email = "carlos.peix@kleer.la"
    participant.event.event_type.name = "Concurso de truco"

    email = EventMailer.welcome_new_event_participant(participant).deliver

    ActionMailer::Base.deliveries.empty?.should_not be true
    email.to.should == ["carlos.peix@kleer.la"]
    email.subject.should == "Kleer | Concurso de truco"
  end

  it "should send standard prices text info if custom prices text is empty" do
    participant = FactoryGirl.build(:participant)
    participant.email = "carlos.peix@kleer.la"
    participant.event.list_price = 200

    email = EventMailer.welcome_new_event_participant(participant).deliver

    text_message = email.body.parts.find {|p| p.content_type.match /plain/}.body.raw_source
    text_message.should include("(ARS) $ 200.00")
  end

  it "should send standard prices html info if custom prices html is empty" do
    participant = FactoryGirl.build(:participant)
    participant.email = "carlos.peix@kleer.la"
    participant.event.list_price = 200

    email = EventMailer.welcome_new_event_participant(participant).deliver

    html_message = email.body.parts.find {|p| p.content_type.match /html/}.body.raw_source
    html_message.should include("(ARS) $ 200.00")
  end

  it "should not send early bird prices EB info is empty" do
    participant = FactoryGirl.build(:participant)
    participant.email = "carlos.peix@kleer.la"
    participant.event.list_price = 200

    email = EventMailer.welcome_new_event_participant(participant).deliver

    text_message = email.body.parts.find {|p| p.content_type.match /plain/}.body.raw_source
    text_message.should_not include("Si pagas antes del")
    html_message = email.body.parts.find {|p| p.content_type.match /html/}.body.raw_source
    html_message.should_not include("Si pagas antes del")
  end

  it "should send early bird prices EB info is available" do
    participant = FactoryGirl.build(:participant)
    participant.email = "carlos.peix@kleer.la"
    participant.event.list_price = 200
    participant.event.eb_end_date = Date.today
    participant.event.eb_price = 180

    email = EventMailer.welcome_new_event_participant(participant).deliver

    text_message = email.body.parts.find {|p| p.content_type.match /plain/}.body.raw_source
    text_message.should include("(ARS) $ 180.00")
    html_message = email.body.parts.find {|p| p.content_type.match /html/}.body.raw_source
    html_message.should include("(ARS) $ 180.00")
  end
end
