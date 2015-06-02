class AddWeatherBatchToObservation < ActiveRecord::Migration
  def change
    add_reference :observations, :weather_batch, index: true, foreign_key: true
  end
end
