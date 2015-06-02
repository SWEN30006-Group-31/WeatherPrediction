class Postcode < ActiveRecord::Base
	has_many :locations
	has_many :observations, :through => :locations
	has_many :predictions, :through => :locations

	# useless? could just self.locations
	def get_stations
		return self.locations.where(active: true)
	end

	# get the nearest station to a given postcode
	def find_nearest_location postcode
		nil
	end

end
