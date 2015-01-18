class CalendarController < ApplicationController
  
  before_filter :authenticate_user!
  
  def home
  end
  
  def events
    
    color_map = {"Nest" => "#587D63", "Weather" => "#5267B0", "Order" => "#B02058"}
    
    current_user_id = current_user.id
    
    p current_user
    
    events = Event.all
    response = []
    events.each do |event|
      if event.user_id == current_user_id
             
        response << {
          "id" => event.id,
          "title" => event.name,
          "allDay" => false,
          "start" => event.starts_at.to_time.iso8601, 
          "url" => '/events/' + event.id.to_s,
          "color" => color_map[event.category]
        }
      end      
    end
    
    respond_to do |format|
      format.json {render json: response }
    end
    
  end
end
