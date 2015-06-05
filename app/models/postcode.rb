# vim:sw=2:sts=2:et

class Postcode < ActiveRecord::Base
  has_many :locations
  has_many :observations, :through => :locations
  has_many :predictions, :through => :locations

  #TODO: Put the distance code into a separate module for re-use.

  def self.get_nearest lat, lon
    #Sorts Postcode in place according to distance from lat, long, and then
    #returns the head of that list.
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

  def get_best_location
    #Gets the location associated with the postcode that is
    #closest to the postcode's co-ordinates.
    (self.locations.where(active: true).sort_by { |loc|
      #Based on: http://www.movable-type.co.uk/scripts/latlong.html
      r         = 6381000
      phi1      = self.lat * Math::PI / 180
      phi2      = loc.lat * Math::PI / 180
      dPhi      = (loc.lat - self.lat) * Math::PI / 180
      dLambda   = (loc.lon - self.lon) * Math::PI / 180
      a = Math.sin(dPhi/2) * Math.sin(dPhi/2) * Math.cos(phi1) *
        Math.cos(phi2) * Math.sin(dLambda/2) * Math.sin(dLambda/2)
      c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a))
      d = r * c }).first
  end
end
