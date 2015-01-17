class CalendarController < ApplicationController
  def home
  end
  
  def events
    events = Event.all
    respond_to do |format|
      format.json {render json: events }
    end
    
  end
end
