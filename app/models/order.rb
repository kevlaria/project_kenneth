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

	def confirm_delivery
		@@client.messages.create(
		  from: '+12673231393',
		  to: '+1' + dropoff_phone_number,
		  body: 'Hey ' + dropoff_name + '. You ordered ' + manifest + ' in your Kenneth Calendar. To confirm the order, click on this link http://kenneth.herokuapp.com/orders/confirm/' + access 
		)
	end

	def make_delivery
		puts self.to_json
	    api_key = 'a36d22c9-532d-46fe-a829-c9218c0cfa50'
	    @customer = 'cus_KAbEzExgDWWWx-'
	    @urlstring_to_post = 'https://api.postmates.com/v1/customers/' + @customer + '/deliveries'
	    pick_phone = pickup_phone_number.insert(3, '-').insert(7, '-')
	    puts pick_phone
	    drop_phone = dropoff_phone_number.insert(3, '-').insert(7, '-')
	    puts drop_phone
	    @result = HTTParty.post(@urlstring_to_post.to_str,
	      :body => {
	      	:manifest => manifest, :pickup_name => pickup_name, :pickup_address => pickup_address, :pickup_phone_number => pick_phone,
			:pickup_business_name => pickup_business_name, :pickup_notes => pickup_notes, :dropoff_name => dropoff_name,
			:dropoff_address => dropoff_address, :dropoff_phone_number => drop_phone, :dropoff_business_name => dropoff_business_name,
			:dropoff_notes => dropoff_notes
	      },
	      :basic_auth => { :username => api_key })
	    puts @result
  	end
end
