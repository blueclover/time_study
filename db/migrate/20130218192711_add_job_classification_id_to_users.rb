class AddJobClassificationIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :job_classification_id, :integer
    add_index :users, :job_classification_id
  end
end
