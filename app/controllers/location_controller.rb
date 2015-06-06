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
    if not (params[:web] =~ /true/)
      request.format = :json
    end
    @locations = Location.all
    respond_to do |format|
      format.html
      format.json
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
    location_id = params[:location_id].to_i
    date = Date.parse(params[:date])
    location = Location.find(location_id)
    current_time = Time.now
    weather_obs_list = Observation.where(location_id: location_id)
    latest_weather = weather_obs_list.last

    if latest_weather.updated_at - current_time > 30
      current_temp = "Null"
    end

    current_cond = "sunny"
    if latest_weather.rainfall == 0
      current_cond = "sunny"
    else
      current_cond = "raining"
    end

    @hash = {}
    @hash["date"] = date
    @hash["current_temp"] = current_temp
    @hash["current_cond"] = current_cond

    measurements = Array.new
    weather_obs_list.each do |weather|
      if weather.timestamp.to_date == date
        measurement_hash = Hash.new
        measurement_hash["time"] = weather.updated_at
        measurement_hash["temp"] = weather.temperature
        measurement_hash["precip"] = weather.rainfall
        measurement_hash["wind_direction"] = weather.wind_dir
        measurement_hash["wind_speed"] = weather.wind_speed
        measurements << measurement_hash
      end
    end
    @hash["measurements"] = measurements
  end

  # '/weather/predicition/:lat/:long/:period' directed here
  def get_prediction
  end

end
