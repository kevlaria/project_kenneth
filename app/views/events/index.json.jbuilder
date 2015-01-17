json.array!(@events) do |event|
  json.extract! event, :id, :name, :type, :starts_at, :event_id
  json.url event_url(event, format: :json)
end
