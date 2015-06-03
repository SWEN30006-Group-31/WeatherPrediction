require 'json'

class PostcodeController < ApplicationController
	
	####### METHODS IN PLAN ########

	# '/weather/data/:post_code/:date' directed here
	def get_weather
		postcode = params[:postcode]
		date = params[:date]
		district = Postcode.find(code: postcode)
		active_stations = Location.where(active: true)
		nearest_active_station = Location.new
		found = false
		active_stations.each do |station|
			lat_diff = ((station.lat - district.lat)**2)**0.5
			long_diff = ((station.lon - district.long)**2)**0.5
			if lat_diff < 0.01 && long_diff < 0.01
				found = true
				nearest_active_station = station
			end
		end
		if found == true
			weathers = Observation.where(location_id: nearest_active_station.id, timestamp: :date)
			
			hash = Hash.new
			location_hash = Hash.new
			measurement_hash = Hash.new
			measurements = Hash.new

			hash["date"] = :date

			location_hash["id"] = nearest_active_station.name
			location_hash["lat"] = nearest_active_station.lat
			location_hash["lon"] = nearest_active_station.lon
			location_hash["last_update"] = nearest_active_station.updated_at

			weathers.each do |weather|
				measurement_hash["time"] = weather.updated_at
				measurement_hash["temp"] = weather.temperature
				measurement_hash["precip"] = weather.rainfall
				measurement_hash["wind_direction"] = weather.wind_dir
				measurement_hash["wind_speed"] = weather.updated_at
				measurements.merge!(measurement_hash)
			end

			location_hash["measurements"] = measurements

			hash["Locations"] = location_hash
		else

		end
		


	end

	# '/weather/predicition/:post_code/:period' directed here
	def get_prediction
		
	end
	
	####### END METHODS IN PLAN ####
end
