class AddDateFieldsToSurveys < ActiveRecord::Migration
  def change
    add_column :surveys, :start_date, :date
    add_column :surveys, :end_date, :date
  end
end
