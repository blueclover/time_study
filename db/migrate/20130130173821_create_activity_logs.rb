class CreateActivityLogs < ActiveRecord::Migration
  def change
    create_table :activity_logs do |t|
      t.date :start_date
      t.integer :user_id
      t.references :survey

      t.timestamps
    end
    add_index :activity_logs, :survey_id
    add_index :activity_logs, :user_id
  end
end
