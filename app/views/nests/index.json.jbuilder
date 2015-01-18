json.array!(@nests) do |nest|
  json.extract! nest, :id, :product, :temperature
  json.url nest_url(nest, format: :json)
end
