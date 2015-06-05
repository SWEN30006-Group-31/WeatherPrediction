require 'nokogiri'
require 'open-uri'
require 'json'
require 'CSV'

BOM_BASE_URL = 'http://www.bom.gov.au'
FIO_BASE_URL = 'https://api.forecast.io/forecast'

WIND_DIRS = %i{ N NNE NE ENE E ESE SE SSE S SSW SW WSW W WNW NW NNW }.freeze
WIND_DIR_MAPPINGS = WIND_DIRS.each_with_index.inject({}) { |m, (dir, index)| m[dir] = index * 360.0 / WIND_DIRS.size; m }.freeze

def load_bom_info_table
  melb_doc = Nokogiri::HTML(open("#{BOM_BASE_URL}/vic/observations/melbourne.shtml"))
  melb_doc.css("#tMELBOURNE").first
end

# def load_postcode_database
#   return list = CSV.read('vicpost.csv')
# end

namespace :weather do
#   # Update the postcode in the DB from the csv file.
#   task :update_postcodes => :environment do
#     active_postcode_ids = Set.new

#     # Get the list of postcodes from the csv file.
#     postcode_list = load_postcode_database
#     postcode_list.each do |postcode|
#       # Retrieve the postcode's information
#       code = postcode[0].to_i
#       name = postcode[1].to_s
#       lat = postcode[2].to_f
#       long = postcode[3].to_f

#       postcode = Postcode.find_or_initialize_by(code: code)
#       postcode.code = code
#       postcode.name = name
#       postcode.lat = lat
#       postcode.long = long

#       psotcode.save if psotcode.changed?
#     end
#   end

  # Update the locations in the DB from BOM. Marks any locations that have disappeared as inactive.
  task :update_locations => :environment do
    active_location_ids = Set.new

    # Get the list of locations from BOM.
    info_table = load_bom_info_table
    info_table.xpath("./tbody/tr/th/a").each do |location_node|
      # Find the location's information
      location_doc = Nokogiri.HTML(open("#{BOM_BASE_URL}#{location_node.attr :href}"))
      station_details = location_doc.css(".stationdetails").first.text
      station_details.match(/Lat:\s*(-?\d+\.\d+)\s+Lon:\s*(-?\d+\.\d+)/)
      name = location_node.text
      lat = $1.to_f
      lon = $2.to_f

      # Update the location in the DB.
      location = Location.find_or_initialize_by(name: name)
      location.lat = lat
      location.lon = lon
      location.active = true
      location.save if location.changed?

      active_location_ids << location.id
    end

    Location.where.not(id: active_location_ids).update_all(active: false)
  end


  # Scrape the BOM site for data.
  task :scrape_bom => :environment do
    source = Source.find_or_create_by(name: "BOM")
    info_table = load_bom_info_table
    info_table.xpath("./tbody/child::*[child::th/a]").each do |row|
      name = row.xpath("./th/a").text
      if location = Location.find_by(name: name, active: true)
        # Find the information.
        temp = row.xpath("./td[contains(@headers, 'obs-temp')]").text.to_f
        rain = row.xpath("./td[contains(@headers, 'obs-rainsince9am')]").text.to_f
        wind_speed = row.xpath("./td[contains(@headers, 'obs-wind-spd-kph')]").text.to_f
        wind_dir_name = row.xpath("./td[contains(@headers, 'obs-wind-dir')]").text
        wind_dir = WIND_DIR_MAPPINGS[wind_dir_name.to_sym]

        # Create a new observation.
        observation = Observation.new(
          temperature: temp,
          rainfall: rain,
          wind_speed: wind_speed,
          wind_dir: wind_dir,
          timestamp: Time.now
        )
        observation.source = source
        observation.location = location
        observation.save
      end
    end
  end


  # Scrapes ForecastIO's API for data.
  task :scrape_forecast_io => :environment do
    source = Source.find_or_create_by(name: "ForecastIO")
    api_key = ENV['FORECAST_IO_API_KEY']
    Location.active_locations.each do |location|
      # Load the data.
      forecast = JSON.parse(open("#{FIO_BASE_URL}/#{api_key}/#{location.lat},#{location.lon}?units=si&exclude=minutely,hourly,daily,alerts,flags").read)
      current_data = forecast["currently"].to_hash.with_indifferent_access

      # Include previous rainfall if it exists. Subtract nine hours to make things easier.
      observation_time = Time.at(current_data[:time])
      last_observation = location.observations.where(source: source).last
      if last_observation
        last_observation_time = last_observation.timestamp.to_time
        if (last_observation_time - 9.hours).to_date == (observation_time - 9.hours).to_date
          rainfall = last_observation.rainfall
        end
      end

      # Calculate new cumulative rainfall total.
      rainfall ||= 0
      last_observation_time ||= (observation_time - 9.hours).to_date.to_time + 9.hours
      rainfall +=  current_data[:precipIntensity] * current_data[:precipProbability] * (observation_time - last_observation_time) / 3600

      # Create a new observation.
      observation = Observation.new(
        temperature: current_data[:temperature],
        rainfall: rainfall,
        wind_speed: current_data[:windSpeed] * 3.6,
        wind_dir: current_data[:windBearing],
        timestamp: observation_time
      )
      observation.source = source
      observation.location = location
      observation.save
    end
  end

end