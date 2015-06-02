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
	def add_observation observation
		observation.location = self
	end

	# why does this need location parameter?
	def retrive_observations location,time
	end

	# Location.get(id) does this?
	def find_location locationID
	end

	def find_nearest_location lat,long
	end

	def get_weather (*args)
	end

	def get_prediction (*args)
	end
end