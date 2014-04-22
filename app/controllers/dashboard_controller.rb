class DashboardController < ApplicationController
  before_filter :authenticate_user!
  before_filter :activate_menu
  
  def index
    @active_menu = "dashboard"
    
    @events = Event.public_and_visible.all(:order => 'date').select{ |ev| !ev.event_type.nil? && ev.registration_link == "" }
    
    @nuevos_registros = 0
    @participantes_contactados = 0
    
    @events.each do |event|
      @nuevos_registros += event.participants.new_ones.count
      @participantes_contactados += event.participants.contacted.count
    end
    
  end
  
  def past_events
    @events = Event.public_and_past_visible.all(:order => 'date desc').select{ |ev| !ev.event_type.nil? }
  end
  
  def pricing
    @active_menu = "pricing"
    @events = Event.public_commercial_visible.all(:order => 'date').select{ |ev| !ev.event_type.nil? }
  end  
  
  def countdown
    @events = Event.public_and_visible.all(:order => 'date').select{ |ev| !ev.event_type.nil? }
  end
  
  def funneling
    @events = Event.all(:order => 'date')
    respond_to do |format|
      format.csv { render :csv => @events, :filename => "events" }
    end
  end
  
  private
  
  def activate_menu
    @active_menu = "dashboard"
  end
  
end
