# == Schema Information
#
# Table name: weathers
#
#  id         :integer          not null, primary key
#  created_at :datetime
#  updated_at :datetime
#  event_id   :integer
#  city       :string(255)
#  state      :string(255)

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


	def get_weather user
		open('http://api.wunderground.com/api/4c59338731743188/geolookup/conditions/q/' + state + '/' + city + '.json') do |f|
		  json_string = f.read
		  parsed_json = JSON.parse(json_string)
		  location = parsed_json['location']['city']
		  temp_f = parsed_json['current_observation']['temp_f']
		  weather = parsed_json['current_observation']['weather']
		  puts temp_f
		  puts weather
		  # print "Current temperature in #{location} is: #{temp_f}\nCurrent conditions are #{weather}\n"
		  if temp_f == nil then
		  	temp_f = 31.8
		  end
		  if weather == nil then
		  	weather = "Rain"
		  end
		  msg = 'Hey ' + user.name + '. The current temperature at ' + city + ', ' + state + ' is ' + temp_f.to_s + '. Weather conditions outside: ' + weather + '.'
		  if (weather == "Rain") then
		  	msg += "If you don't have an umbrella, you can ask Kenneth to buy one for you"		  
		  elsif (temp_f < 60) then
		  	msg += "It is cold outside! If you don't have a jacket, you should ask Kenneth to buy one for you."
		  elsif (temp_f > 80) then
		  	msg += "It is quite warm outside! If you don't have shorts, you should ask Kenneth to buy one for you."
		  elsif (weather == "Clear") then
		  	msg += "It is a beautiful day outside! Go have fun!"
		  end	
		  	
		  @@client.messages.create(
		  		from: '+12673231393',
		  		to: '+1' + user.phone.to_s,
		  		body: msg
		  )
		end



	end
	
	# get_weather('MA', 'Boston')


end
