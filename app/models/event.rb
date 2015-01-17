# == Schema Information
#
# Table name: events
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  type       :string(255)
#  time       :datetime
#  event_id   :integer
#  created_at :datetime
#  updated_at :datetime
#

class Event < ActiveRecord::Base
  belongs_to :user


  def processOrders
  	@now = Event.where(:time => 1.minute.ago..Time.now);
  	@next = Event.where(:time => Time.now..1.hour.from_now);

  	@now.each do |event|
  		if event.type == "Order" then
  			order = Order.find(event.event_id)
  			order.notify
  		end
  	end

  	@next.each do |event|
   		if event.type == "Order" then
   			order = Order.find(event.event_id)
   			order.message
  		end 	
  	end
  end

end
