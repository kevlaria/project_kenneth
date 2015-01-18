
# == Schema Information
#
# Table name: weathers
#
#  id         :integer          not null, primary key
#  created_at :datetime
#  updated_at :datetime
#

require 'open-uri'
require 'json'


class Weather < ActiveRecord::Base
  belongs_to :event
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


	def get_weather(user)
		open('http://api.wunderground.com/api/4c59338731743188/geolookup/conditions/q/' + state + '/' + city + '.json') do |f|
		  json_string = f.read
		  parsed_json = JSON.parse(json_string)
		  location = parsed_json['location']['city']
		  temp_f = parsed_json['current_observation']['temp_f']
		  weather = parsed_json['current_observation']['weather']
		  # print "Current temperature in #{location} is: #{temp_f}\nCurrent conditions are #{weather}\n"
		end

		@@client.messages.create(
		  from: '+12673231393',
		  to: '+1' + current_user.phone,
		  body: 'Hey ' + current_user.name + '. The current weather is ' + weather + 'To confirm the order, click on this link http://158.130.107.192/orders/confirm/' + access 
		)

	end
	
	# get_weather('MA', 'Boston')


end
