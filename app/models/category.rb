class Category < ActiveRecord::Base
  has_and_belongs_to_many :event_types
  
  attr_accessible :codename, :description, :name, :events
  
  validates :name, :description, :codename, :presence => true
end
