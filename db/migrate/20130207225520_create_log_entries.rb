class CreateLogEntries < ActiveRecord::Migration
  def change
    create_table :log_entries do |t|
      t.date :date
      t.references :activity_log

      t.timestamps
    end
    add_index :log_entries, :activity_log_id
  end
end
