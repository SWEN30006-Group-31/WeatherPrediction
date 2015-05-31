class Location < ActiveRecord::Base
	belongs_to :postcode
	has_many :observations
	def self.active_locations
		self.where(active: true)
	end
end
