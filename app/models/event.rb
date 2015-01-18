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

class Event < ActiveRecord::Base
  has_one :nest
  has_one :order
  has_one :weather
  belongs_to :user
  

	default_scope {order('starts_at ASC')}
  

  def self.processOrders
  	@now = Event.where(:starts_at => Time.now - 5.hours..Time.now - 5.hours + 1.minute)
  	@next = Event.where(:starts_at => Time.now - 6.hours..Time.now - 6.hours + 1.minute)
  	@now.each do |event|
  		case event.category
      when "Order"
  			order = Order.find(event.order)
  			order.make_delivery
      when "Nest"
        user = User.find(event.user_id)
        nest = Nest.find(event.nest)
        nest.change_thermostat user
			when "Weather"
				weather = Weather.find(event.weather)
        user = User.find(event.user_id)
				weather.get_weather user
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
