class Trainer < ActiveRecord::Base
  belongs_to :country  
  has_and_belongs_to_many :event_types
  has_many :events
  has_many :participants, :through => :events
  
  scope :kleerer, where(:is_kleerer => true)
  
  validates :name, :presence => true
  
  def gravatar_picture_url
    hash = "asljasld"
    hash = Digest::MD5.hexdigest(self.gravatar_email) unless self.gravatar_email.nil?
    "http://www.gravatar.com/avatar/#{hash}"
  end
  
  def to_xml( options )
    super( options.merge(:methods =>  :gravatar_picture_url ) )
  end

  def average_rating
    cualified_participants = participants.attended.select{ |p| !p.trainer_rating.nil? }

    if cualified_participants.length > 0
      cualified_participants.collect{ |p| p.trainer_rating}.sum.to_f/cualified_participants.length
    else
      nil
    end

  end

  def net_promoter_score
    promoter_count = participants.attended.promoter.length.to_f
    passive_count = participants.attended.passive.length.to_f
    detractor_count = participants.attended.detractor.length.to_f
    attended_count = (promoter_count+passive_count+detractor_count)

    if attended_count > 0
      promoter_percent = promoter_count / attended_count
      detractor_percent = detractor_count / attended_count

      (promoter_percent - detractor_percent).round(2)

    else
      nil
    end

  end
  
end
