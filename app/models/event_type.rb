class EventType < ActiveRecord::Base
  
  has_and_belongs_to_many :trainers
  
  attr_accessible :name, :duration, :goal, :description, :recipients, :program, :trainer_ids, :trainers
                  
  validates :name, :duration, :goal, :description, :recipients, :program, :trainers, :presence => true
  
end
