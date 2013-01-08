class Trainer < ActiveRecord::Base
  
  attr_reader :gravatar_picture_url
  
  has_and_belongs_to_many :event_types
  
  validates :name, :presence => true
  
  def gravatar_picture_url
    hash = "asljasld"
    hash = Digest::MD5.hexdigest(self.gravatar_email) unless self.gravatar_email.nil?
    "http://www.gravatar.com/avatar/#{hash}"
  end
  
  def to_xml( options )
    super( options.merge(:methods =>  :gravatar_picture_url ) )
  end
  
end
