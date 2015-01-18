# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

event = Event.create([{name: "Shopping", starts_at:Time.now, user_id: 1, category:"Order"}, 
  {name: "Change thermometer", starts_at:(Time.now - 1.day), user_id:1, category:"Nest"},
  {name: "Cold", starts_at:(Time.now - 2.day), user_id:1, category:"Weather"},
  {name: "Unknown", starts_at:(Time.now - 2.day), user_id:1}
  ])
  
order = Order.create([
  { manifest: "Chicken",
    pickup_name: "K",
    pickup_address: "3600 Chestnut Street",
    pickup_phone_number: "(999)-999-9999",
    pickup_business_name: "Kenneth Co",
    dropoff_name: "K",
    dropoff_address: "3600 Chestnut Street",
    dropoff_phone_number: "(999)-999-9999",
    dropoff_business_name: "Kenneth Co",
    event_id: 5
    }  
])

nest = Nest.create([
  {
    product: "Home heater",
    temperature: 70,
    event_id: 6
  }  
])

weather = Weather.create([
  {
    event_id: 7,
    city: "Philadelphia",
    state: "Pennsylvania"
  }
])
