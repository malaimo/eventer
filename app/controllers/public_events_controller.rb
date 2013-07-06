class PublicEventsController < ApplicationController
  def show
    @event = Event.public_and_visible.find(params[:id])
  end
  
  def watch
     @event = Event.public_and_visible.find(params[:id])
     
     respond_to do |format|
       format.html { render :layout => "webinar_layout" }
     end
  end
  
end