# == Schema Information
#
# Table name: orders
#
#  id                    :integer          not null, primary key
#  manifest              :text
#  pickup_name           :string(255)
#  pickup_address        :string(255)
#  pickup_phone_number   :string(255)
#  pickup_business_name  :string(255)
#  pickup_notes          :text
#  dropoff_name          :string(255)
#  dropoff_address       :string(255)
#  dropoff_phone_number  :string(255)
#  dropoff_business_name :string(255)
#  dropoff_notes         :text
#  quote_id              :string(255)
#  created_at            :datetime
#  updated_at            :datetime
#  confirmation          :boolean          default(FALSE), not null
#  access                :string(255)
#  event_id              :integer
#

class Order < ActiveRecord::Base

  @@account_sid = 'ACd882ca7c1db91ca067d5072ac3f0a5b8'
  @@auth_token = 'c64507802fc8ffd839ca321db09a827b'

  # set up a client to talk to the Twilio REST API
  @@client = Twilio::REST::Client.new @@account_sid, @@auth_token

  # alternatively, you can preconfigure the client like so
  Twilio.configure do |config|
    config.account_sid = @@account_sid
    config.auth_token = @@auth_token
  end

  # and then you can create a new client without parameters
  @@client = Twilio::REST::Client.new

	def event
		Event.where(category: 'Order', event_id: id)
	end

	def confirm_delivery
		@@client.messages.create(
		  from: '+12673231393',
		  to: '+1' + dropoff_phone_number,
		  body: 'Hey ' + dropoff_name + '. You ordered ' + manifest + ' in your Kenneth Calendar. To confirm the order, click on this link http://158.130.171.52:3000/orders/confirm/' + access 
		)
	end

	def make_delivery
		@@client.messages.create(
		  from: '+12673231393',
		  to: '+1' + dropoff_phone_number,
		  body: 'Hey ' + dropoff_name + '. You order of ' + manifest + ' is on your way! It should arrive in the next hour. Stay close to your phone!'
		)
	    api_key = 'a36d22c9-532d-46fe-a829-c9218c0cfa50'
	    @customer = 'cus_KAbEzExgDWWWx-'
	    @urlstring_to_post = 'https://api.postmates.com/v1/customers/' + @customer + '/deliveries'
	    pick_phone = pickup_phone_number.insert(3, '-').insert(7, '-')
	    drop_phone = dropoff_phone_number.insert(3, '-').insert(7, '-')
	    @result = HTTParty.post(@urlstring_to_post.to_str,
	      :body => {
	      	:manifest => manifest, :pickup_name => pickup_name, :pickup_address => pickup_address, :pickup_phone_number => pick_phone,
			:pickup_business_name => pickup_business_name, :pickup_notes => pickup_notes, :dropoff_name => dropoff_name,
			:dropoff_address => dropoff_address, :dropoff_phone_number => drop_phone, :dropoff_business_name => dropoff_business_name,
			:dropoff_notes => dropoff_notes
	      },
	      :basic_auth => { :username => api_key })
  	end
end
