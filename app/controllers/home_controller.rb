class HomeController < ApplicationController
  def index
    @events = Event.public_commercial_visible.all(:order => 'date')
    respond_to do |format|
      format.html
      format.xml { render :xml => @events.to_xml({:include => [:country,:event_type,:trainer,:categories], methods: :human_date} ) }
      format.json { render json: @events }  
    end
  end
  
  def index_community
    @events = Event.public_community_visible.all(:order => 'date')
    respond_to do |format|
      format.html
      format.xml { render :xml => @events.to_xml({:include => [:country,:event_type,:trainer,:categories], methods: :human_date} ) }
      format.json { render json: @events }  
    end
  end
  
  def show
    @event = Event.public_and_visible.find(params[:id])
    respond_to do |format|
      format.xml { render :xml => @event.to_xml({:include => [:country,:event_type,:trainer,:categories], methods: :human_date} ) }
      format.json { render json: @event }  
    end
  end
  
  def trainers
    @trainers = Trainer.all(:order => ['country_id','name'])
    respond_to do |format|
      format.html
      format.xml { render :xml => @trainers.to_xml(:include => :country ) }
      format.json { render json: @trainers }  
    end
  end
  
  def kleerers
    @trainers = Trainer.kleerer.all(:order => ['country_id','name'])
    respond_to do |format|
      format.html
      format.xml { render :xml => @trainers.to_xml(:include => :country ) }
      format.json { render json: @trainers }  
    end
  end
  
  def categories
    @categories = Category.all(:order => ['name'])
    respond_to do |format|
      format.html
      format.xml { render :xml => @categories.to_xml }
      format.json { render json: @categories }  
    end
  end
  
end
