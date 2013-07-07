require 'valid_email'

class Participant < ActiveRecord::Base
  belongs_to :event
  attr_accessible :email, :fname, :lname, :phone, :event_id, :status, :notes
  
  validates :email, :fname, :lname, :phone, :event, :presence => true
  
  validates :email, :email => true
  
  scope :new_ones, where(:status => "N")
  scope :confirmed, where(:status => "C")
  scope :contacted, where(:status => "T")
  scope :cancelled, where(:status => "X")
  scope :deffered, where(:status => "D")   
  
  after_initialize :initialize_defaults
  
  comma do
    self.lname 'Apellido'
    self.fname 'Nombre'
    self.email 'Email'
    self.phone 'Telefono'
    self.participant_status 'Estado'
  end
  
  def initialize_defaults
    if new_record?
      self.status = "N"
    end
  end
  
  def participant_status
    if self.status == "N"
      return "Nuevo"
    elsif self.status == "T"
      return "Contactado"
    elsif self.status == "C"
      return "Confirmado"
    elsif self.status == "D"
      return "Pospuesto"
    elsif self.status == "X"
      return "Cancelado"
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
  
  def confirm!()
    self.status = "C"
  end
end
