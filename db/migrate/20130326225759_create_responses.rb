class CreateResponses < ActiveRecord::Migration
  def change
    create_table :responses do |t|
      t.references :user_moment
      t.references :activity_category
      t.integer :q1selection
      t.integer :q2selection
      t.integer :q3selection
      t.string :q1text
      t.string :q2text
      t.string :q3text

      t.timestamps
    end
    add_index :responses, :user_moment_id
    add_index :responses, :activity_category_id
  end
end
