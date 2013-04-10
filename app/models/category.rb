class Category < ActiveRecord::Base
  attr_accessible :codename, :description, :name
  validates :name, :description, :codename, :presence => true
  
  has_and_belongs_to_many :event_types
end
