class AddHoursToLogEntries < ActiveRecord::Migration
  def change
    add_column :log_entries, :hours, :float
  end
end
