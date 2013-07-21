class AjaxController < ApplicationController
  def events_update_trainer_select
    @trainers_for_event_type = EventType.find(params[:id]).trainers.sort{|p1,p2| p1.name <=> p2.name} unless params[:id].blank?
    render "/events/_trainers_select", :layout => false
  end
end