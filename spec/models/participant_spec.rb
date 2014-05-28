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

  it "should require the influence zone" do
    @participant.influence_zone = nil
    
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
  
  it "should be valid if there's no referer code" do
    @participant.referer_code = ""
    
    @participant.valid?.should be true
  end
  
  it "should be valid if there's a referer code" do
    @participant.referer_code = "UNCODIGO"
    
    @participant.valid?.should be true
  end
  
  it "should let someone confirm it" do
    @participant.confirm!
    @participant.status.should == "C"
  end
  
  it "should let someone contact it" do
    @participant.contact!
    @participant.status.should == "T"
  end
  
  it "should let someone mark attended it" do
    @participant.is_present?.should be false
    @participant.attend!
    @participant.status.should == "A"
    @participant.is_present?.should be true
  end

  context "given a batch load" do

    before(:each) do
      @event = FactoryGirl.create(:event)
      @influence_zone = FactoryGirl.create(:influence_zone)
      @status = "A"
    end
    
    it "sould allow a participant to be created from a batch line using commas" do
      participant_data_line = "Alaimo, Martin, malaimo@gmail.com, 1234-5678"

      Participant.create_from_batch_line( participant_data_line, @event, @influence_zone, @status ).should be true

      Participant.all.count.should == 1
      created_participant = Participant.first
      created_participant.fname.should == "Martin"
      created_participant.lname.should == "Alaimo"
      created_participant.email.should == "malaimo@gmail.com"
      created_participant.phone.should == "1234-5678"
    end

    it "sould allow a participant to be created from a batch line using tabs" do
      participant_data_line = "Alaimo\tMartin\tmalaimo@gmail.com\t1234-5678"

      Participant.create_from_batch_line( participant_data_line, @event, @influence_zone, @status ).should be true

      Participant.all.count.should == 1
      created_participant = Participant.first
      created_participant.fname.should == "Martin"
      created_participant.lname.should == "Alaimo"
      created_participant.email.should == "malaimo@gmail.com"
      created_participant.phone.should == "1234-5678"
    end

    it "sould allow a participant to be created from a batch line without a telephone number" do
      participant_data_line = "Alaimo\tMartin\tmalaimo@gmail.com"

      Participant.create_from_batch_line( participant_data_line, @event, @influence_zone, @status ).should be true
      Participant.all.count.should == 1
      Participant.first.phone.should == "N/A"
    end

    it "sould not allow a participant to be created from a batch line without fname" do
      participant_data_line = "Alaimo,,malaimo@gmail.com"

      Participant.create_from_batch_line( participant_data_line, @event, @influence_zone, @status ).should be false
      Participant.all.count.should == 0
    end
  
    it "sould not allow a participant to be created from a batch line without lname" do
      participant_data_line = ",Martin,malaimo@gmail.com"

      Participant.create_from_batch_line( participant_data_line, @event, @influence_zone, @status ).should be false
      Participant.all.count.should == 0
    end

    it "sould not allow a participant to be created from a batch line with a malformed e-mail" do
      participant_data_line = "Alaimo, Martin, ksjdhaSDJHasf"

      Participant.create_from_batch_line( participant_data_line, @event, @influence_zone, @status ).should be false
      Participant.all.count.should == 0
    end

    it "sould not allow a participant to be created from a batch line with less than 3 parameters" do
      participant_data_line = "Alaimo, Martin"

      Participant.create_from_batch_line( participant_data_line, @event, @influence_zone, @status ).should be false
      Participant.all.count.should == 0
    end

  end
  
end
