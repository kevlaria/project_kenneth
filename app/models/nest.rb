# == Schema Information
#
# Table name: nests
#
#  id          :integer          not null, primary key
#  product     :string(255)
#  temperature :integer
#  created_at  :datetime
#  updated_at  :datetime
#  user_id     :integer
#

class Nest < ActiveRecord::Base
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


	def change_thermostat user
		nest = NestThermostat::Nest.new(email: "paulsl@seas.upenn.edu", password: "password")
		nest.temperature = temperature
		puts user.phone
		puts user.name
		@@client.messages.create(
		  from: '+12673231393',
		  to: '+1' + user.phone.to_s,
		  body: 'Hey ' + user.name.to_s + '. We just changed your Nest thermostat temperature to ' + temperature.to_s + ' as scheduled.'
		)
	end

end
