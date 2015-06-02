class Location < ActiveRecord::Base
	belongs_to :postcode
	has_many :observations
	has_many :predictions
	has_many :weather_batches, :through => :observations
	has_many :sources, :through => :observations

	def self.active_locations
		self.where(active: true)
	end

	def self.add_observation observation

	end

	def self.retrive_observation location,time
	end

	def self.find_location locationID
	end

	def self.find_nearest_location lat,long
	end

	def self.get_weather (*args)
	end

	def self.get_prediction (*args)
	end
end