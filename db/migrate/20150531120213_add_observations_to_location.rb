class AddObservationsToLocation < ActiveRecord::Migration
  def change
    add_reference :locations, :observation, index: true, foreign_key: true
  end
end
