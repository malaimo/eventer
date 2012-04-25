class PublicEventsController < ApplicationController
  def show
    @event = Event.public_and_visible.find(params[:id])
  end
end