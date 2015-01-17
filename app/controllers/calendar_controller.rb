class CalendarController < ApplicationController
  
  before_filter :authenticate_user!
  
  def home
  end
  
  def events
    
    current_user_id = current_user.id
    
    events = Event.all
    response = []
    events.each do |event|
      if event.user_id == current_user_id
        response << {
          "id" => event.id,
          "title" => event.name,
          "allDay" => false,
          "start" => event.starts_at.to_time.iso8601, 
          "url" => '/events/' + event.id.to_s + '/edit'    
        }
      end      
    end
    
    respond_to do |format|
      format.json {render json: response }
    end
    
  end
end
