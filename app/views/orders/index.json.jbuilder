json.array!(@orders) do |order|
  json.extract! order, :id, :manifest, :pickup_name, :pickup_address, :pickup_phone_number, :pickup_business_name, :pickup_notes, :dropoff_name, :dropoff_address, :dropoff_phone_number, :dropoff_business_name, :dropoff_notes, :quote_id
  json.url order_url(order, format: :json)
end
