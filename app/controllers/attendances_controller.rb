class AttendancesController < ApplicationController

  def index
  end

  def show
  end

  def new
    @event = Event.find(params[:event_id])
  end

  def create
  end

end
