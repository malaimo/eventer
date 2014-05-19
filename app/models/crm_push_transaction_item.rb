require 'curb'
require 'json'
require 'open-uri'

class CrmPushTransactionItem < ActiveRecord::Base

  belongs_to :crm_push_transaction
  belongs_to :participant

  attr_accessible :crm_push_transaction, :log, :participant, :result

  def push!
  	self.log = "001 push iniciado para #{self.participant.email}\n"

  	crm_ids = get_crm_ids(self.participant.email)

  	if crm_ids.size == 0
      self.log += "002 persona inexistente en CRM\n"
    else
    	if self.participant.is_confirmed_or_attended?
	    	crm_ids.each do |crm_id|
	    		self.log += "003 actualizando persona con id:#{crm_id}\n"
	    		
	    		event_tag = crm_push_transaction.event.event_type.tag_name
	    		if !event_tag.nil? && event_tag != ""
	    			add_crm_tag crm_id, event_tag
	    		end

	    		trainer_tag = crm_push_transaction.event.trainer.tag_name
	    		if !trainer_tag.nil? && trainer_tag != ""
	    			add_crm_tag crm_id, trainer_tag
	    		end

	    	end
    	end
    end

  	self.save
  end

  private

  def add_crm_tag(id_crm, tag)
	  encoded_tag = URI::encode(tag)
	  c = create_crm_curl("https://kleer.capsulecrm.com/api/party/#{id_crm}/tag/#{encoded_tag}")
	  c.http_post
	  self.log += "004 tag #{tag} aplicada\n"
  end

  def get_crm_ids(email)
	  crm_ids = Array.new

	  encoded_email = URI::encode(email)
	  c = create_crm_curl("https://kleer.capsulecrm.com/api/party?email=#{encoded_email}")
	  c.headers["Accept"] = "application/json"
	  c.http_get
	  response = JSON.parse( c.body_str )

	  if response["parties"]["@size"].to_i > 0
	    if response["parties"]["person"].class == Hash
	      crm_ids << response["parties"]["person"]["id"]
	    elsif response["parties"]["person"].class == Array
	      response["parties"]["person"].each do |person|
	        crm_ids << person["id"]
	      end
	    end
	  end
	  
	  crm_ids
  
  end

  def create_crm_curl(url)
	  c = Curl::Easy.new(url)

	  c.http_auth_types = :basic
	  c.username = ENV["KEVENTER_CRM_TOKEN"]
	  c.password = ENV["KEVENTER_CRM_PASSWORD"]
	  
	  c
  end
end
