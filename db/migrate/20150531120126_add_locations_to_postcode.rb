class AddLocationsToPostcode < ActiveRecord::Migration
  def change
    add_reference :postcodes, :location, index: true, foreign_key: true
  end
end
