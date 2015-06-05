# vim:sts=2:sw=2:et

class Location < ActiveRecord::Base
  belongs_to :postcode
  has_many :observations
  has_many :predictions
  has_many :sources, :through => :observations

  # return a collection of active locations
  def self.active_locations
    self.where(active: true)
  end

  # return the location closest to a given co-ordinate
  def self.get_nearest lat, lon
    #Sorts Location in place according to distance from lat, long, and then
    #returns the head of that list.
    (Location.all.sort_by { |loc|
      #Based on: http://www.movable-type.co.uk/scripts/latlong.html
      r         = 6381000
      phi1      = lat * Math::PI / 180
      phi2      = log.lat * Math::PI / 180
      dPhi      = (log.lat - lat) * Math::PI / 180
      dLambda   = (log.lon - lon) * Math::PI / 180
      a = Math.sin(dPhi/2) * Math.sin(dPhi/2) * Math.cos(phi1) *
        Math.cos(phi2) * Math.sin(dLambda/2) * Math.sin(dLambda/2)
      c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a))
      d = r * c }).first
  end

  # not sure if its correct and Why do we need this method?
  # return a collection of observations given a date
  def retrive_observation time
    date = time
    observationData = Observations.where(timestamp: :date)
    return observationData
  end

  # get the last update for the location 
  def last_update
    self.observations.last.timestamp
  end

end
