# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20150531120213) do

  create_table "locations", force: :cascade do |t|
    t.string   "name"
    t.float    "lat"
    t.float    "long"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "observation_id"
  end

  add_index "locations", ["observation_id"], name: "index_locations_on_observation_id"

  create_table "observations", force: :cascade do |t|
    t.float    "temp"
    t.float    "dew_point"
    t.float    "rain"
    t.float    "wind_speed"
    t.float    "wind_direction"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "postcodes", force: :cascade do |t|
    t.string   "code"
    t.string   "name"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "location_id"
  end

  add_index "postcodes", ["location_id"], name: "index_postcodes_on_location_id"

end
