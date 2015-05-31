class CreateObservations < ActiveRecord::Migration
  def change
    create_table :observations do |t|
      t.float :temp
      t.float :dew_point
      t.float :rain
      t.float :wind_speed
      t.float :wind_direction

      t.timestamps null: false
    end
  end
end
