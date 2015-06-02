class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :name
      t.float :lat
      t.float :lon
      t.boolean :active

      t.timestamps null: false
    end
  end
end
