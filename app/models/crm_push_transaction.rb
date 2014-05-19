class CrmPushTransaction < ActiveRecord::Base
	has_many :items, :foreign_key => 'crm_push_transaction_id', :class_name => "CrmPushTransactionItem"
	belongs_to :event
	belongs_to :user

  	attr_accessible :event, :user

  	def start!
  		self.event.participants.each do |participant|
  			crm_push_item = CrmPushTransactionItem.create(:crm_push_transaction => self, :participant => participant)
  			crm_push_item.push!
  		end
  		EventMailer.alert_event_crm_push_finished(self)
  	end
end