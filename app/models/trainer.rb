class Trainer < ActiveRecord::Base
  
  has_and_belongs_to_many :event_types
  
  validates :name, :presence => true
  
end
