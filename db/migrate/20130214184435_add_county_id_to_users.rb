class AddCountyIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :county_id, :integer
    add_index :users, :county_id
  end
end
