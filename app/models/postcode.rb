# vim:sw=2:sts=2:et

class Postcode < ActiveRecord::Base
  has_many :locations
  has_many :observations, :through => :locations
  has_many :predictions, :through => :locations

  def self.get_pcode lat, lon
    #Sorts Postcode in place according to distance from lat, long, and then
    #returns the head of that list.
    #TODO: See if there's a way to do this non-destructively.
    (Postcode.all.sort_by { |pcode|
      #Based on: http://www.movable-type.co.uk/scripts/latlong.html
      r         = 6381000
      phi1      = lat * Math::PI / 180
      phi2      = pcode.lat * Math::PI / 180
      dPhi      = (pcode.lat - lat) * Math::PI / 180
      dLambda   = (pcode.lon - lon) * Math::PI / 180
      a = Math.sin(dPhi/2) * Math.sin(dPhi/2) * Math.cos(phi1) *
        Math.cos(phi2) * Math.sin(dLambda/2) * Math.sin(dLambda/2)
      c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a))
      d = r * c }).first
  end

  def self.find_nearest_location postcode
    # Find all regions in that postcode
    given_postcode = Postcode.where(code: postcode)

    # Retrieve all active stations
    active_location_list = Location.where(active: true)

    # Find the nearest stations to the regions in the given postcode
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
    end
    return nearest_location
  end
end
