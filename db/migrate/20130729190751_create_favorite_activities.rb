class CreateFavoriteActivities < ActiveRecord::Migration
  def change
    create_table :favorite_activities do |t|
      t.integer :user_id
      t.integer :county_id
      t.integer :job_classification_id
      t.references :activity_category, null: false
    end
    add_index :favorite_activities, :user_id
    add_index :favorite_activities, :county_id
    add_index :favorite_activities, :job_classification_id
  end
end
