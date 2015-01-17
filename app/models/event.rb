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
  
  belongs_to :user
  
	default_scope order('starts_at ASC')
  

  def self.processOrders
  	@now = Event.where(:starts_at => Time.now - 5.hours..Time.now - 5.hours + 1.minute)
  	@next = Event.where(:starts_at => Time.now - 6.hours..Time.now - 6.hours + 1.minute)
  	@now.each do |event|
  		if event.category == "Order" then
  			order = Order.find(event.event_id)
  			order.make_delivery
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
