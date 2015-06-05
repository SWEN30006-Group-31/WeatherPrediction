class ChangeTimestampToDatetime < ActiveRecord::Migration
  def change
  	change_column :observations, :timestamp, :datetime
  end
end
