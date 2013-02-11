class CreateActivityCategories < ActiveRecord::Migration
  def change
    create_table :activity_categories do |t|
      t.string :name
      t.string :code
      t.decimal :weight, default: 1

      t.timestamps
    end
  end
end
