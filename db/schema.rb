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

ActiveRecord::Schema.define(version: 20150605141300) do

  create_table "locations", force: :cascade do |t|
    t.string   "name"
    t.float    "lat"
    t.float    "lon"
    t.boolean  "active"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "postcode_id"
  end

  add_index "locations", ["postcode_id"], name: "index_locations_on_postcode_id"

  create_table "observations", force: :cascade do |t|
    t.float    "temperature"
    t.float    "dew_point"
    t.float    "rainfall"
    t.float    "wind_speed"
    t.float    "wind_dir"
    t.datetime "timestamp"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "location_id"
    t.integer  "source_id"
  end

  add_index "observations", ["location_id"], name: "index_observations_on_location_id"
  add_index "observations", ["source_id"], name: "index_observations_on_source_id"

  create_table "postcodes", force: :cascade do |t|
    t.integer  "code"
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float    "lat"
    t.float    "lon"
  end

  create_table "predictions", force: :cascade do |t|
    t.float    "rainfall"
    t.float    "rainfall_probability"
    t.float    "dew_point"
    t.float    "dew_probability"
    t.float    "temperature"
    t.float    "temperature_probability"
    t.float    "wind_speed"
    t.float    "wind_speed_probability"
    t.float    "wind_dir"
    t.float    "wind_dir_probability"
    t.date     "timestamp"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "location_id"
  end

  add_index "predictions", ["location_id"], name: "index_predictions_on_location_id"

  create_table "sources", force: :cascade do |t|
    t.string   "name"
    t.string   "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
