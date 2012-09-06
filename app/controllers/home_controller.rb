class HomeController < ApplicationController
  def index
    @events = Event.public_and_visible.all(:order => 'date')
    respond_to do |format|
      format.html
      format.xml { render :xml => @events.to_xml(:include => [:country,:event_type,:trainer] ) }
      format.json { render json: @events }  
    end
  end
  
  def show
    @event = Event.public_and_visible.find(params[:id])
    respond_to do |format|
      format.xml { render :xml => @event.to_xml(:include => [:country,:event_type,:trainer] ) }
      format.json { render json: @event }  
    end
  end
end
