# vim:sts=2:sw=2:et

class LocationController < ApplicationController

  ####### METHODS IN PLAN ########
  def init_enum
  end

  def get_next_loc
  end

  def has_more_locs
  end

  # '/weather/locations' directed here
  def all_locations
    @locations = Location.all
    respond_to do |format|
      format.html
    end
  end

  ### DO WE NEED BOTH OF THESE NEXT TWO?
  # def get_weather_location
  # end

  # def get_weather_coordinate
  # end

  ### DO WE NEED BOTH OF THESE NEXT TWO?
  # def get_prediction_location
  # end

  # def get_prediction_coordinate
  # end

  ####### END METHODS IN PLAN ####

  # '/weather/data/:location_id/:date' directed here

  # Current_condition needs fix
  def get_weather
    location_id = params[:location_id]
    date = params[:date]
    location = Location.find(id: location_id)
    current_time = Time.now
    weather_obs_list = Observation.where(location_id: location_id, timestamp: :date)
    latest_weather = weather_obs_list.last

    if latest_weather.updated_at - current_time > 30
      current_temp = "Null"
    end

    current_cond = "sunny"
    if latest_weather.rainfall == 0
      current_cond = "sunny"
    end

    hash = {}
    hash["date"] = :date
    hash["current_temp"] = current_temp
    hash["current_cond"] = current_cond

    weather_obs_list.each do |weather|
      measurement_hash = Hash.new
      measurement_hash["time"] = weather.updated_at
      measurement_hash["temp"] = weather.temperature
      measurement_hash["precip"] = weather.rainfall
      measurement_hash["wind_direction"] = weather.wind_dir
      measurement_hash["wind_speed"] = weather.updated_at
      measurements << measurement_hash
    end
    hash["measurements"] = measurements

    return hash
  end

  # '/weather/predicition/:lat/:long/:period' directed here
  def get_prediction
  end

  # MOVED FROM LOCATION MODEL
  # function to find the nearest location given lat+long
  def find_nearest_location lat, long
    active_locations = Location.where(active: true)
    max_distance = 10000000000
    nearest_location = Location.new
    active_locations.each do |location|
      distance = (location.lat - lat )**2 + (location.lon - long)**2
      if distance < max_distance
        max_distance = distance
        nearest_location = location
      end
    end
    return nearest_location
  end
end
