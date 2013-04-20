class Category < ActiveRecord::Base
  has_and_belongs_to_many :event_types
  
  attr_accessible :codename, :description, :name, :tagline, :events, :visible, :order
  
  validates :name, :description, :codename, :tagline, :presence => true
  
  scope :visible_ones, where(:visible => true).order("'order' ASC")
end
