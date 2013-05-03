class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.references :log_entry
      t.references :activity_category
      t.float :hours

      t.timestamps
    end
    add_index :activities, :log_entry_id
    add_index :activities, :activity_category_id
  end
end
