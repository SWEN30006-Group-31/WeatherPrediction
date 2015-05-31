json.array!(@postcodes) do |postcode|
  json.extract! postcode, :id, :code, :name
  json.url postcode_url(postcode, format: :json)
end
