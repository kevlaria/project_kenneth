json.array!(@weathers) do |weather|
  json.extract! weather, :id
  json.url weather_url(weather, format: :json)
end
