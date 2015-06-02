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

ActiveRecord::Schema.define(version: 20150602073809) do

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
    t.date     "timestamp"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "weather_batch_id"
    t.integer  "location_id"
    t.integer  "source_id"
  end

  add_index "observations", ["location_id"], name: "index_observations_on_location_id"
  add_index "observations", ["source_id"], name: "index_observations_on_source_id"
  add_index "observations", ["weather_batch_id"], name: "index_observations_on_weather_batch_id"

  create_table "postcodes", force: :cascade do |t|
    t.integer  "code"
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "predictions", force: :cascade do |t|
    t.float    "temperature_probability"
    t.float    "dew_probability"
    t.float    "rain_probability"
    t.float    "wind_probability"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "sources", force: :cascade do |t|
    t.string   "name"
    t.string   "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "weather_batches", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
