class CreateObservations < ActiveRecord::Migration
  def change
    create_table :observations do |t|
      t.float :temperature
      t.float :dew_point
      t.float :rainfall
      t.float :wind_speed
      t.float :wind_dir
      t.date :timestamp

      t.timestamps null: false
    end
  end
end
