class CreatePostcodes < ActiveRecord::Migration
  def change
    create_table :postcodes do |t|
      t.integer :code
      t.string :name

      t.timestamps null: false
    end
  end
end
