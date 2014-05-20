class EventType < ActiveRecord::Base
  
  has_and_belongs_to_many :trainers
  has_and_belongs_to_many :categories
  has_many :events
  
  attr_accessible :name, :duration, :goal, :description, :recipients, :program, :trainer_ids, :trainers, 
                  :faq, :materials, :category_ids, :categories, :events, :include_in_catalog, :elevator_pitch, 
                  :learnings, :takeaways, :tag_name
                  
  validates :name, :duration, :description, :recipients, :program, :trainers, :elevator_pitch, :presence => true
  
  def short_name
    if self.name.length >= 30
      self.name[0..29] + "..."
    else
      self.name
    end
  end
  
end
