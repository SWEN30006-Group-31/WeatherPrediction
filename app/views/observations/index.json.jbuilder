json.array!(@observations) do |observation|
  json.extract! observation, :id, :temp, :dew_point, :rain, :wind_speed, :wind_direction
  json.url observation_url(observation, format: :json)
end
