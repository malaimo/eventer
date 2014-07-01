class RemoveIsWebinarFlagFromEvent < ActiveRecord::Migration
  def change
  	remove_column :events, :is_webinar
  end
end
