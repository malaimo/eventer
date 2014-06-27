class EventType < ActiveRecord::Base
  
  has_and_belongs_to_many :trainers
  has_and_belongs_to_many :categories
  has_many :events
  has_many :participants, :through => :events
  
  attr_accessible :name, :duration, :goal, :description, :recipients, :program, :trainer_ids, :trainers, 
                  :faq, :materials, :category_ids, :categories, :events, :include_in_catalog, :elevator_pitch, 
                  :learnings, :takeaways, :tag_name, :csd_eligible
                  
  validates :name, :duration, :description, :recipients, :program, :trainers, :elevator_pitch, :presence => true
  
  def short_name
    if self.name.length >= 30
      self.name[0..29] + "..."
    else
      self.name
    end
  end

  def average_rating
    cualified_participants = participants.attended.select{ |p| !p.event_rating.nil? }

    if cualified_participants.length > 0
      cualified_participants.collect{ |p| p.event_rating}.sum.to_f/cualified_participants.length
    else
      nil
    end

  end

  def net_promoter_score
    promoter_count = participants.attended.promoter.length.to_f
    passive_count = participants.attended.passive.length.to_f
    detractor_count = participants.attended.detractor.length.to_f
    attended_count = (promoter_count+passive_count+detractor_count)

    if (promoter_count+detractor_count) > 0
      promoter_percent = promoter_count / attended_count
      detractor_percent = detractor_count / attended_count

      (promoter_percent - detractor_percent).round(2)

    else
      nil
    end

  end

  def participant_count
    participants.attended.count
  end

  def promoter_count
    participants.attended.promoter.count
  end
  
end
