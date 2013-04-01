class Event < ActiveRecord::Base
  belongs_to :country
  belongs_to :trainer
  belongs_to :event_type
  has_many :participants

  scope :visible, where(:cancelled => false).where("date >= ?", DateTime.now)
  scope :public_events,  where("visibility_type = 'pu' or visibility_type = 'co'")
  scope :public_commercial_events,  where(:visibility_type => "pu")
  scope :public_community_events,  where(:visibility_type => "co")
  scope :public_commercial_visible, self.visible.public_commercial_events
  scope :public_community_visible, self.visible.public_community_events
  scope :public_and_visible, self.visible.public_events

  after_initialize :initialize_defaults

  attr_accessible :event_type_id, :trainer_id, :country_id, :date, :place, :capacity, :city, :visibility_type, :list_price,
                  :list_price_plus_tax, :list_price_2_pax_discount, :list_price_3plus_pax_discount,
                  :eb_price, :eb_end_date, :draft, :cancelled, :registration_link, :is_sold_out, :participants

  validates :date, :place, :capacity, :city, :visibility_type, :list_price,
            :country, :trainer, :event_type, :presence => true

  validates :capacity, :numericality => { :greater_than => 0, :message => :capacity_should_be_greater_than_0 }

  validates_each :date do |record, attr, value|
    record.errors.add(attr, :event_date_in_past) unless !value.nil? && value > Time.zone.today
  end

  validates_each :eb_end_date do |record, attr, value|
      record.errors.add(attr, :eb_end_date_should_be_earlier_than_event_date) unless value.nil? || value < record.date
  end

  validates_each :eb_price do |record, attr, value|
      record.errors.add(attr, :eb_price_should_be_smaller_than_list_price) unless value.nil? || value < record.list_price
  end

  validates_each :list_price_2_pax_discount  do |record, attr, value|
    if !value.nil? && (value > 0 && record.visibility_type == 'pr')
      record.errors.add(attr, :private_event_should_not_have_discounts)
    end
  end

  validates_each :list_price_3plus_pax_discount  do |record, attr, value|
    if !value.nil? && (value > 0 && record.visibility_type == 'pr')
      record.errors.add(attr, :private_event_should_not_have_discounts)
    end
  end

  def initialize_defaults
    if new_record?
#      self.draft = true
    end
  end

  def completion
    if self.capacity > 0
      self.participants.confirmed.count*1.0/self.capacity
    else
      1.0
    end
  end

  def weeks_from(now=Date.today)
    from_date = now.beginning_of_week
    to_date = self.date.beginning_of_week

    weeks = (to_date - from_date) / 7
  end



end
