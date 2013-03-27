class Participant < ActiveRecord::Base
  belongs_to :event
  attr_accessible :email, :fname, :lname, :phone, :event_id, :status, :notes
  
  validates :email, :fname, :lname, :phone, :event, :presence => true
  
  scope :new_ones, where(:status => "N")
  scope :confirmed, where(:status => "C")
  scope :contacted, where(:status => "T")
  scope :cancelled, where(:status => "X")
  scope :deffered, where(:status => "D")   
  
  after_initialize :initialize_defaults
  
  def initialize_defaults
    if new_record?
      self.status = "N"
    end
  end
  
  def status_sort_order
    if self.status == "N"
      return 1
    elsif self.status == "T"
      return 2
    elsif self.status == "C"
      return 3
    elsif self.status == "D"
      return 4
    elsif self.status == "X"
      return 5
    else
      return 6
    end
  end
end
