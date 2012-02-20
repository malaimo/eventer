class Event < ActiveRecord::Base
  belongs_to :country
  belongs_to :trainer
  
  after_initialize :initialize_defaults
  
  attr_accessible :trainer_id, :country_id, :name, :date, :place, :capacity, :city, :visibility_type, :list_price, 
                  :list_price_plus_tax, :list_price_2_pax_discount, :list_price_3plus_pax_discount, 
                  :seb_price, :seb_end_date, :eb_price, :eb_end_date, :description, :recipients, :program, 
                  :draft, :cancelled
                  
  validates :name, :date, :place, :capacity, :city, :visibility_type, :list_price, :description, :recipients, 
            :program, :country, :trainer, :presence => true
  
  validates :capacity, :numericality => { :greater_than => 0, :message => :capacity_should_be_greater_than_0 }
  
  validates_each :date do |record, attr, value|
    record.errors.add(attr, :event_date_in_past) unless !value.nil? && value > Time.zone.today
  end
  
  validates_each :eb_end_date do |record, attr, value|
      record.errors.add(attr, :eb_end_date_should_be_earlier_than_event_date) unless value.nil? || value < record.date
  end
  
  validates_each :seb_end_date do |record, attr, value|
    if !value.nil? 
      record.errors.add(attr, :seb_end_date_should_be_earlier_than_event_date) unless value < record.date
      if !record.eb_end_date.nil?
        record.errors.add(attr, :seb_end_date_should_be_earlier_than_eb_date) unless value < record.eb_end_date
      end
    end
  end
  
  validates_each :eb_price do |record, attr, value|
      record.errors.add(attr, :eb_price_should_be_smaller_than_list_price) unless value.nil? || value < record.list_price
  end
  
  validates_each :seb_price do |record, attr, value|
    if !value.nil?
      record.errors.add(attr, :seb_price_should_be_smaller_than_list_price) unless value < record.list_price
      if !record.eb_price.nil?
        record.errors.add(attr, :seb_price_should_be_smaller_than_eb_price) unless value < record.eb_price
      end
    end
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
      self.draft = true
    end
  end
  

end
