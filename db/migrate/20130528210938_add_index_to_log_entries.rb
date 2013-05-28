class AddIndexToLogEntries < ActiveRecord::Migration
  def change
  	add_index :log_entries, [:activity_log_id, :date], unique: true
  end
end
