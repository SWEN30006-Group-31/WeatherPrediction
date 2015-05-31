json.array!(@locations) do |location|
  json.extract! location, :id, :name, :lat, :long
  json.url location_url(location, format: :json)
end
