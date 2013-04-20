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
  
  it "should require its tagline" do
    @category.tagline = ""
    
    @category.valid?.should be false
  end
  
  it "should have a visibility flag" do
    @category.visible = false
    
    @category.visible.should be false
  end
  
  it "should have an order index" do
    @category.order = 1
    
    @category.order.should == 1
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
  
  it "should have a visible scope" do
    cat1 = FactoryGirl.build(:category)
    cat1.visible = true
    cat1.save!
    
    cat2 = FactoryGirl.build(:category)
    cat2.visible = true
    cat2.save!
    
    cat3 = FactoryGirl.build(:category)
    cat3.visible = false
    cat3.save!
    
    Category.all.count.should == 3
    Category.visible_ones.count.should == 2
  end
  
end

