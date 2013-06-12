class RemoveForeignKeyFromActivities < ActiveRecord::Migration
	change_table :activities do |t|
		t.remove_foreign_key :activity_categories
		t.remove_foreign_key :log_entries
	end
end
