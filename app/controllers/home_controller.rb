class HomeController < ApplicationController
  def index
    @events = Event.public_and_visible.all(:order => 'date')
  end
end
