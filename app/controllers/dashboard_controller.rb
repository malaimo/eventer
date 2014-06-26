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
    @events = Event.past_visible.all(:order => 'date desc').select{ |ev| !ev.event_type.nil? }
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
      format.csv { render :csv => @events, :filename => "funelling" }
    end
  end

  def ratings
    @active_menu = "ratings"

    global_promoter_count = Participant.attended.promoter.length.to_f
    global_passive_count = Participant.attended.passive.length.to_f
    global_detractor_count = Participant.attended.detractor.length.to_f
    global_attended_count = (global_promoter_count+global_passive_count+global_detractor_count)

    if global_attended_count > 0
      global_promoter_percent = global_promoter_count / global_attended_count
      global_detractor_percent = global_detractor_count / global_attended_count

      @global_net_promoter_score = (global_promoter_percent - global_detractor_percent).round(2)

    else
      @global_net_promoter_score = "N/A"
    end

    @average_trainer_rating = Participant.average("trainer_rating").to_f.round(2)
    @average_event_rating = Participant.average("event_rating").to_f.round(2)

    @top_5_nps_event_types = EventType.all.select{ |et| !et.net_promoter_score.nil? }.sort_by(&:net_promoter_score).reverse![0..4]
    @top_5_nps_trainers = Trainer.all.select{ |t| !t.net_promoter_score.nil? }.sort_by(&:net_promoter_score).reverse![0..4]
  

    @top_10_event_types = EventType.all.select{ |et| !et.average_rating.nil? }.sort_by(&:average_rating).reverse![0..9]
    @top_10_events = Event.all.select{ |e| !e.average_rating.nil? }.sort_by(&:average_rating).reverse![0..9]
    @top_10_trainers = Trainer.all.select{ |t| !t.average_rating.nil? }.sort_by(&:average_rating).reverse![0..9]
  end
  
  private
  
  def activate_menu
    @active_menu = "dashboard"
  end
  
end
