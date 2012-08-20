class EventType < ActiveRecord::Base
  
  attr_accessible :name, :duration, :goal, :description, :recipients, :program
                  
  validates :name, :duration, :goal, :description, :recipients, :program, :presence => true
  
end
