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

	# not sure if its correct and Why do we need this method?
	# return a collection of observations given a date
	def retrive_observation time
		date = time
		observationData = Observations.where(timestamp: :date)
		return observationData
	
	end