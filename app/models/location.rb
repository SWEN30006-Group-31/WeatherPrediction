class Location < ActiveRecord::Base
	belongs_to :postcode
	has_many :observations
	has_many :predictions
	has_many :weather_batches, :through => :observations
	has_many :sources, :through => :observations

	# return a collection of active locations
	def self.active_locations
		self.where(active: true)
	end

	# NEEDS FIXING LOL
	# return a collection of observations given a date
	def retrive_observation time
		observationData = Array.new
		data[:temperature]=Observation.time.temperature
		data[:dew_point]=Observation.time.dew_point
		data[:rain] = Observation.time.dew_point
		data[:wind_speed] = Observation.time.wind_speed
		data[:wind_direction] = Observation.time.wind_direction
		observationData.push(data)
		return observationData
	end
end