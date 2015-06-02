class CreatePredictions < ActiveRecord::Migration
  def change
    create_table :predictions do |t|
      t.float :rainfall
      t.float :rainfall_probability
      t.float :dew_point
      t.float :dew_probability
      t.float :temperature
      t.float :temperature_probability
      t.float :wind_speed
      t.float :wind_speed_probability
      t.float :wind_dir
      t.float :wind_dir_probability
      t.date :timestamp

      t.timestamps null: false
    end
  end
end
