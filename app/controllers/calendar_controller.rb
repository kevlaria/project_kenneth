class CalendarController < ApplicationController
  def home
  end
  
  def events
    events = Event.all
    response = []
    events.each do |event|
      response << {
        "id" => event.id,
        "title" => event.name,
        "allDay" => false,
        "start" => event.starts_at.to_time.iso8601, 
        "url" => '/events/' + event.id.to_s + '/edit'    
      }
      
    end
    
    respond_to do |format|
      format.json {render json: response }
    end
    
  end
end
