# encoding: utf-8
require 'valid_email'

class Participant < ActiveRecord::Base
  belongs_to :event
  belongs_to :influence_zone
  
  attr_accessible :email, :fname, :lname, :phone, :event_id, :status, :notes, :influence_zone_id, :influence_zone, :referer_code
  
  validates :email, :fname, :lname, :phone, :event, :influence_zone, :presence => true
  
  validates :email, :email => true
  
  scope :new_ones, where(:status => "N")
  scope :confirmed, where(:status => "C")
  scope :contacted, where(:status => "T")
  scope :cancelled, where(:status => "X")
  scope :deffered, where(:status => "D")
  scope :attended, where(:status => "A")
  
  after_initialize :initialize_defaults
  
  comma do
    self.lname 'Apellido'
    self.fname 'Nombre'
    self.email 'Email'
    self.phone 'Telefono'
    self.human_status 'Estado'
    self.influence_zone_name 'Ciudad/Provincia/Región'
    self.influence_zone_country 'País'
    self.influence_zone_tag 'Zona de Influencia (tag)'
  end
  
  def initialize_defaults
    if new_record?
      self.status = "N" unless !self.status.nil?
      self.verification_code = Digest::SHA1.hexdigest([Time.now, rand].join)[1..20].upcase
    end
  end
  
  def human_status
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
    elsif self.status == "A"
      return "Presente"
    end
  end
  
  def status_sort_order
    if self.status == "N"
      return 1
    elsif self.status == "T"
      return 2
    elsif self.status == "C"
      return 3
    elsif self.status == "A"
      return 4
    elsif self.status == "D"
      return 5
    elsif self.status == "X"
      return 6
    else
      return 7
    end
  end
  
  def confirm!
    self.status = "C"
  end
  
  def contact!
    self.status = "T"
    if !self.notes.nil?
      self.notes += "\n"
    else
      self.notes = ""
    end
    self.notes += "#{Date.today.strftime('%d-%b')}: Info (auto)"
  end
  
  def attend!
    self.status = "A"
  end
  
  def is_present?
    (self.status == "A")
  end

  def is_confirmed_or_present?
    (self.status == "A" || self.status == "C")
  end
  
  def influence_zone_tag
    self.influence_zone.nil? ? "" : self.influence_zone.tag_name
  end
  
  def influence_zone_name
    self.influence_zone.nil? ? "" : self.influence_zone.zone_name
  end
  
  def influence_zone_country
    if !self.influence_zone.nil?
      self.influence_zone.country.nil? ? "" : self.influence_zone.country.name
    else
      ""
    end
  end

  def generate_certificate_and_notify
    certificate_filename = ParticipantsHelper::generate_certificate( self, "A4" )
    certificate_url_A4 = ParticipantsHelper::upload_certificate( certificate_filename )

    certificate_filename = ParticipantsHelper::generate_certificate( self, "LETTER" )
    certificate_url_LETTER = ParticipantsHelper::upload_certificate( certificate_filename )

    EventMailer.send_certificate(self, certificate_url_A4, certificate_url_LETTER)
  end

  def self.create_from_batch_line(participant_data_line, event, influence_zone, status)

    data_attibutes = participant_data_line.split("\t")
    if data_attibutes.size == 1
      data_attibutes = participant_data_line.split(",")
    end

    if data_attibutes.size >= 3
      lname = data_attibutes[0].strip
      fname = data_attibutes[1].strip
      email = data_attibutes[2].strip

      if data_attibutes.size == 3
        phone = "N/A"
      else
        phone = data_attibutes[3].strip
      end

      participant = Participant.new(:fname => fname, :lname => lname, :email => email,
                                    :phone => phone, :event_id => event.id, :notes => "Batch load",
                                    :influence_zone_id => influence_zone.id, :status => status)
      participant.save
    else
      false
    end

  end

end
