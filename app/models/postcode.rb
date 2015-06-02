class Postcode < ActiveRecord::Base
	has_many :locations
	has_many :observations, :through => :locations
	has_many :predictions, :through => :locations

	def self.get_stations
		
	end

	def self.find_nearest_location postcode
		given_postcode = Postcode.find(code: postcode)
		active_location_list = Location.where(active: true)
		max_distance = 100000000000000
		# Find the nearest location
		active_location_list.each do |location|
			distance = location.lat
		end
	end

end
