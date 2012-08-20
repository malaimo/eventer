class EventType < ActiveRecord::Base
  
  attr_accessible :name, :description, :recipients, :program
                  
  validates :name, :description, :recipients, :program, :presence => true
  
end
