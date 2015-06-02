class AddLonToPostcode < ActiveRecord::Migration
  def change
    add_column :postcodes, :lon, :float
  end
end
