class Location < ActiveRecord::Base
	belongs_to :postcode
	has_many :observations
	has_many :predictions
	has_many :weather_batches, :through => :observations
	has_many :sources, :through => :observations

	def self.active_locations
		self.where(active: true)
	end

	# needed? location should be added to observation as it is the parent
	def add_observation observation,time
		Observation.time.location = self
	end


	# why does this need location parameter?
	def self.retrive_observation location,time
		observationData = Array.new
		data[:temperature]=Observation.time.location.temperature
		data[:dew_point]=Observation.time.location.dew_point
		data[:rain] = Observation.time.location.dew_point
		data[:wind_speed] = Observation.time.location.wind_speed
		data[:wind_direction] = Observation.time.location.wind_direction
		observationData.push(data)
		end
		return observationData
	end

	# Location.get(id) does this?
	#I agree
	def self.find_location locationID
		
	end

	def self.find_nearest_location lat,long

	end

	def self.get_weather (*args)
		if args.size == 2
			#get weather according to the Location ID
		else
			#get weather according to the lat long
		end
	end

	def self.get_prediction (*args)
		if args.size == 2
			#get prediction according to the location ID
		else
			#get prediction according to the lat long
		end

	end
end