class Postcode < ActiveRecord::Base
	has_many :locations
	has_many :observations, :through => :locations

	def get_stations
	end

	def find_nearest_location Postcode

	end

end
