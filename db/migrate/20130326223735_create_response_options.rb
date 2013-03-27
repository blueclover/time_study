class CreateResponseOptions < ActiveRecord::Migration
  def change
    create_table :response_options do |t|
      t.string :description
      t.integer :related_question
      t.integer :parent_id
      t.references :activity_category

      t.timestamps
    end
    add_index :response_options, :activity_category_id
  end
end
