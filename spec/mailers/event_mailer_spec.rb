# encoding: utf-8

require "spec_helper"
describe EventMailer do
  
  before (:each) do
    @participant = FactoryGirl.build(:participant)
    @participant.email = "martin.alaimo@kleer.la"
    @participant.event.event_type.name = "Concurso de truco"
  end
  
  it "should queue and verify a simple email" do

    email = EventMailer.welcome_new_event_participant(@participant).deliver

    ActionMailer::Base.deliveries.empty?.should_not be true
    email.to.should == ["martin.alaimo@kleer.la"]
    email.subject.should == "Kleer | Concurso de truco"
  end

  it "should send standard prices text info if custom prices text is empty" do
    @participant.event.list_price = 200

    email = EventMailer.welcome_new_event_participant(@participant).deliver

    text_message = email.body.parts.find {|p| p.content_type.match /plain/}.body.raw_source
    text_message.should include("(ARS) $ 200.00")
  end

  it "should send standard prices html info if custom prices html is empty" do
    email = EventMailer.welcome_new_event_participant(@participant).deliver

    html_message = email.body.parts.find {|p| p.content_type.match /html/}.body.raw_source
    html_message.should include("(ARS) $ 200.00")
  end

  it "should not send early bird prices EB info is empty" do
    email = EventMailer.welcome_new_event_participant(@participant).deliver

    text_message = email.body.parts.find {|p| p.content_type.match /plain/}.body.raw_source
    text_message.should_not include("Si pagas antes del")
    html_message = email.body.parts.find {|p| p.content_type.match /html/}.body.raw_source
    html_message.should_not include("Si pagas antes del")
  end

  it "should send early bird prices EB info is available" do
    @participant.event.eb_end_date = Date.today
    @participant.event.eb_price = 180

    email = EventMailer.welcome_new_event_participant(@participant).deliver

    text_message = email.body.parts.find {|p| p.content_type.match /plain/}.body.raw_source
    text_message.should include("(ARS) $ 180.00")
    html_message = email.body.parts.find {|p| p.content_type.match /html/}.body.raw_source
    html_message.should include("(ARS) $ 180.00")
  end
  
  it "should show 2 person discount if present" do
    @participant.event.list_price_2_pax_discount = 10

    email = EventMailer.welcome_new_event_participant(@participant).deliver

    text_message = email.body.parts.find {|p| p.content_type.match /plain/}.body.raw_source
    text_message.should include("10% dto. para 2 personas.")
        
    html_message = email.body.parts.find {|p| p.content_type.match /html/}.body.raw_source
    html_message.should include("10% dto. para 2 personas.")
  end
  
  it "should show 3+ person discount if present" do
    @participant.event.list_price_3plus_pax_discount = 15

    email = EventMailer.welcome_new_event_participant(@participant).deliver

    text_message = email.body.parts.find {|p| p.content_type.match /plain/}.body.raw_source
    text_message.should include("15% dto. para 3 o más personas.")
    
    html_message = email.body.parts.find {|p| p.content_type.match /html/}.body.raw_source
    html_message.should include("15% dto. para 3 o más personas.")
  end
  
  it "should not send list price, early bird prices, discounts if custom text is present" do
    @participant.event.list_price = 200
    @participant.event.eb_end_date = Date.today
    @participant.event.eb_price = 180
    @participant.event.list_price_2_pax_discount = 10
    @participant.event.list_price_3plus_pax_discount = 15
    
    @participant.event.custom_prices_email_text = "texto customizado"
    
    email = EventMailer.welcome_new_event_participant(@participant).deliver

    text_message = email.body.parts.find {|p| p.content_type.match /plain/}.body.raw_source
    text_message.should_not include("(ARS) $ 200.00")
    text_message.should_not include("(ARS) $ 180.00")
    text_message.should_not include("Si pagas antes del")
    text_message.should_not include("10% dto. para 2 personas.")
    text_message.should_not include("15% dto. para 3 o más personas.")
    
    html_message = email.body.parts.find {|p| p.content_type.match /html/}.body.raw_source
    html_message.should_not include("(ARS) $ 200.00")
    html_message.should_not include("(ARS) $ 180.00")
    html_message.should_not include("Si pagas antes del")
    html_message.should_not include("10% dto. para 2 personas.")
    html_message.should_not include("15% dto. para 3 o más personas.")
  end
  
  it "should send the custom text if custom text is present" do
    @participant.event.custom_prices_email_text = "texto customizado"
    
    email = EventMailer.welcome_new_event_participant(@participant).deliver

    text_message = email.body.parts.find {|p| p.content_type.match /plain/}.body.raw_source
    text_message.should include("texto customizado")
    
    html_message = email.body.parts.find {|p| p.content_type.match /html/}.body.raw_source
    html_message.should include("texto customizado")
  end
  
  it "should send the custom text in HTML format if custom text markdown is present" do
    @participant.event.custom_prices_email_text = "**texto customizado**: 16"
    
    email = EventMailer.welcome_new_event_participant(@participant).deliver
    
    html_message = email.body.parts.find {|p| p.content_type.match /html/}.body.raw_source
    html_message.should include("<strong>texto customizado</strong>: 16")

  end  
  
end
