class AddLatToPostcode < ActiveRecord::Migration
  def change
    add_column :postcodes, :lat, :float
  end
end
