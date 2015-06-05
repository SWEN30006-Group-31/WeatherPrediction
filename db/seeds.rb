# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)



########### GET DEM POSTCODES ROCKIN #############
require 'csv'

def load_postcode_database
  return list = CSV.read('db/postcode.csv')
end

def add_postcodes_from_file
    active_postcode_ids = Set.new

    # Get the list of postcodes from the csv file.
    postcode_list = load_postcode_database
    postcode_list.each do |postcode|
      # Retrieve the postcode's information
      code = postcode[0].to_i
      name = postcode[1].to_s
      lat = postcode[2].to_f
      lon = postcode[3].to_f

      postcode = Postcode.find_or_initialize_by(code: code)
      postcode.code = code
      postcode.name = name
      postcode.lat = lat
      postcode.lon = lon

      postcode.save
    end
end

add_postcodes_from_file
########### POSTCODES ROCKIN! #############