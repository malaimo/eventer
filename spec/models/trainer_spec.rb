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
end
