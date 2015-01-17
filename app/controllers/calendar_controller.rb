class CalendarController < ApplicationController
  def home
    @events = Event.all
  end
end
