class AddCountyIdToSurveys < ActiveRecord::Migration
  def change
    add_column :surveys, :county_id, :integer
    add_index :surveys, :county_id
  end
end
