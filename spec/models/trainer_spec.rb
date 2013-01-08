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

end
