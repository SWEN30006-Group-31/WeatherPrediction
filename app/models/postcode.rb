# vim:tw=2:sw=2:et

class Postcode < ActiveRecord::Base
  has_many :locations
  has_many :observations, :through => :locations
  has_many :predictions, :through => :locations

  def self.get_stations

  end

  def self.find_nearest_location postcode
    # Find all regions in that postcode
    given_postcode = Postcode.where(code: postcode)

    # Retrieve all active stations
    active_location_list = Location.where(active: true)

    #Find the nearest stations to the regions in the given postcode
    nearest_location_list = Array.new
    given_postcode.each do |postcode|
      max_distance = 100000000000000
      nearest_location = Location.new
      # Search for the nearest
      active_location_list.each do |location|
        distance = (location.lat - given_postcode.lat)**2 + (location.lon - given_postcode.long)**2
        if distance < max_distance
          max_distance = distance
          nearest_location = location
        end
      end
      # Put the nearest in the list
      nearest_location_list << nearest_location
    end
    return nearest_location_list
  end

end
