class PublicEventsController < ApplicationController
  def show
    @event = Event.public_and_visible.find(params[:id])
  end
  
  def watch
     @event = Event.find(params[:event_id])
     
     respond_to do |format|
       if params[:participant_id].nil?
         format.html { redirect_to new_event_participant_path, notice: t('flash.participant.registration_required') }
       else
         @participant = Participant.find_by_id(params[:participant_id])
         if @participant.nil?
           format.html { redirect_to new_event_participant_path, notice: t('flash.participant.not_found') }
         #elsif @participant.is_present?
         #  format.html { redirect_to new_event_participant_path, notice: t('flash.participant.is_attending') }
         else
           @participant.attend!
           @participant.save
           format.html { render :layout => "webinar_layout" }
         end
       end
     end
  end
  
end