class AddDurationAndTimeToEvent < ActiveRecord::Migration
  def up
    change_table :events do |t|
      t.integer :duration
      t.time :start_time
      t.time :end_time
    end
	end
	
	def down
		remove_column :events, :duration
		remove_column :events, :start_time
		remove_column :events, :end_time
	end
end
