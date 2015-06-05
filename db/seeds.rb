# vim:sts=2:sw=2:et
#
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
  #Timings from jdenholm@bowman-arch:
  # postcode.csv: 6.60s user, 0.90s system, 2% cpu, 4:22.95 total
  # postcode_uniq.csv: 2.16s user, 0.25 system, 3% cpu, 1:04.45 total
  return list = CSV.read('db/postcode_uniq.csv')
end

def add_postcodes_from_file
  active_postcode_ids = Set.new

  # Get the list of postcodes from the csv file.
  postcode_list = load_postcode_database
  postcode_list.each do |csv_line|
    # Retrieve the postcode's information
    code = csv_line[0].to_i
    name = csv_line[1].to_s
    lat = csv_line[2].to_f
    lon = csv_line[3].to_f

    # Put it in the database
    Postcode.find_or_create_by(code: code) do |pcode|
      pcode.name  = name
      pcode.lat   = lat
      pcode.lon   = lon
    end
  end
end

add_postcodes_from_file
########### POSTCODES ROCKIN! #############
