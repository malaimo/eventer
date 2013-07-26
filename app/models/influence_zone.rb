class InfluenceZone < ActiveRecord::Base
  belongs_to :country
  
  attr_accessible :tag_name, :zone_name, :country_id, :country
  
  validates :tag_name, :country, :presence => true
  
  def display_name
    self.zone_name == "" ? self.country.name : self.country.name+" - "+self.zone_name
  end
end
