class Postcode < ActiveRecord::Base
	has_many :locations
	has_many :observations, :through => :locations
	has_many :predictions, :through => :locations

	def self.get_stations
		
	end

	def self.find_nearest_location postcode
		location_list = Location.all
		location_list.each do |location|
			
		end

end
