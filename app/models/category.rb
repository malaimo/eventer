class Category < ActiveRecord::Base
  has_and_belongs_to_many :event_types
  
  attr_accessible :codename, :description, :name, :tagline, :events
  
  validates :name, :description, :codename, :tagline, :presence => true
end
