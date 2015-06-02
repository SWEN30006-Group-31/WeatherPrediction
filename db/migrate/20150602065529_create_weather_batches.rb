class CreateWeatherBatches < ActiveRecord::Migration
  def change
    create_table :weather_batches do |t|

      t.timestamps null: false
    end
  end
end
