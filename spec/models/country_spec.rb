require 'spec_helper'

describe Country do
  it "shown as AR - Argentina" do
    c = FactoryGirl.build(:country)
    c.to_s.should == "AR - Argentina"
  end
end
