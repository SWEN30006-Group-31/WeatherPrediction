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

end