# == Schema Information
#
# Table name: events
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  category   :string(255)
#  starts_at  :datetime
#  event_id   :integer
#  created_at :datetime
#  updated_at :datetime
#  user_id    :integer
#

require 'open-uri'
require 'json'

class Event < ActiveRecord::Base
  has_one :nest
  has_one :weather
  belongs_to :user
  

	default_scope {order('starts_at ASC')}
  
	def order
		if category == 'Order'
			Order.find(event_id)
		end
	end

  def self.processOrders
  	@now = Event.where(:starts_at => Time.now - 5.hours..Time.now - 5.hours + 1.minute)
  	@next = Event.where(:starts_at => Time.now - 6.hours..Time.now - 6.hours + 1.minute)

  	@now.each do |event|
      user = User.find(event.user_id)
      open('http://api.wunderground.com/api/4c59338731743188/geolookup/conditions/q/PA/Philadelphia.json') do |f|
        json_string = f.read
        parsed_json = JSON.parse(json_string)
        location = parsed_json['location']['city']
        temp_f = parsed_json['current_observation']['temp_f']
        weather = parsed_json['current_observation']['weather']
        puts temp_f.to_s
        puts weather
        if event.condition == nil || (event.condition == "Rainy" && weather == "Rain") ||
          (event.condition == "Clear" && weather != "Rain") || (event.condition == "Hot" && temp_f > 80) ||
          (event.condition == "Cold" && temp_f < 60) then
          case event.category
          when "Order"
            order = Order.find(event.order)
            order.make_delivery
          when "Nest"
            nest = Nest.find(event.nest)
            nest.change_thermostat user
          when "Weather"
            weather = Weather.find(event.weather)
            weather.get_weather user
          end
        end
      end
    end

    @next.each do |event|
        if event.category == "Order" then
          order = Order.find(event.event_id)
          order.confirm_delivery
        end   
    end
  end

end
