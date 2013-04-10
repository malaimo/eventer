require 'spec_helper'

describe Category do
  it { should have_and_belong_to_many(:event_types) }
  
  before(:each) do
    @category = FactoryGirl.build(:category)
  end
  
  it "should be valid" do
    @category.valid?.should be true
  end
  
  it "should require its name" do
    @category.name = ""
    
    @category.valid?.should be false
  end
  
  it "should require its description" do
    @category.description = ""
    
    @category.valid?.should be false
  end
  
  it "should require its codename" do
    @category.codename = ""
    
    @category.valid?.should be false
  end

  it "should get " do
    biz = FactoryGirl.build(:category)
    
    tec = FactoryGirl.build(:category)
    tec.codename = "TEC"
    
    csm = FactoryGirl.build(:event_type)
    csm.categories << biz
    csm.save!
    
    kanban = FactoryGirl.build(:event_type)
    kanban.categories << biz
    kanban.save!
    
    tdd = FactoryGirl.build(:event_type)
    tdd.categories << tec
    tdd.save!
    
    biz.event_types.count.should == 2
  end
  
end

