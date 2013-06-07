class AddForeignKeyToActivities < ActiveRecord::Migration
	change_table :activities do |t|
		t.foreign_key :activity_categories, dependent: :restrict
		t.foreign_key :log_entries, dependent: :delete
	end
end
