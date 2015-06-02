class CreatePredictions < ActiveRecord::Migration
  def change
    create_table :predictions do |t|
      t.float :temperature_probability
      t.float :dew_probability
      t.float :rain_probability
      t.float :wind_probability

      t.timestamps null: false
    end
  end
end
