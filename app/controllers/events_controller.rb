class EventsController < ApplicationController

  def index
    @events = Event.all
  end

  def show
    @event = Event.find(params[:id])
    @event_end = @event.start_date + (@event.duration * 60)
  end

  def create

    @user = current_user

    @event = Event.new(:administrator => @user, :start_date => params[:start_date], :duration => params[:duration], :title => params[:title], :description => params[:description], :price => params[:price], :location => params[:location])
      if @event.save
        redirect_to root_path
      else
        render events_path
      end
  end

end
