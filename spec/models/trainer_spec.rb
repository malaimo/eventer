require 'spec_helper'

describe Trainer do
  it "should require a name" do
    t = Factory.build(:trainer)
    
    t.name = ""

    t.valid?.should be false
  end
end
