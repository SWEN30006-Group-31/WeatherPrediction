class LocationController < ApplicationController
	
	####### METHODS IN PLAN ########
	def init_enum
	end

	def get_next_loc
	end

	def has_more_locs
	end

	# '/weather/locations' directed here
	def all_locations
	end

	### DO WE NEED BOTH OF THESE NEXT TWO?
	# def get_weather_location
	# end

	# def get_weather_coordinate
	# end

	### DO WE NEED BOTH OF THESE NEXT TWO?
	# def get_prediction_location
	# end

	# def get_prediction_coordinate
	# end

	####### END METHODS IN PLAN ####

	# '/weather/data/:location_id/:date' directed here
	def get_weather
	end

	# '/weather/predicition/:lat/:long/:period' directed here
	def get_prediction
	end

	# MOVED FROM LOCATION MODEL
	# function to find the nearest location given lat+long
	def find_nearest_location lat, long
		active_locations = Location.where(active: true)
		max_distance = 10000000000
		nearest_location = Location.new
		active_locations.each do |location|
			distance = (location.lat - lat )**2 + (location.lon - long)**2
			if distance < max_distance
				max_distance = distance
				nearest_location = location
			end
		end
		return nearest_location
	end
end