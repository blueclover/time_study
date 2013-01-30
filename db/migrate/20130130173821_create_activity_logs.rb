class CreateActivityLogs < ActiveRecord::Migration
  def change
    create_table :activity_logs do |t|
      t.date :start_date
      t.integer :staff_id
      t.references :survey

      t.timestamps
    end
    add_index :activity_logs, :survey_id
  end
end
