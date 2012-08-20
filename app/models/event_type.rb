class EventType < ActiveRecord::Base
  
  attr_accessible :name, :goal, :description, :recipients, :program
                  
  validates :name, :goal, :description, :recipients, :program, :presence => true
  
end
