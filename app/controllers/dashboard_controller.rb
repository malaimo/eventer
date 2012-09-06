class DashboardController < ApplicationController
  before_filter :authenticate_user!
  
  def index
    @events = Event.public_and_visible.all(:order => 'date')
  end
end
