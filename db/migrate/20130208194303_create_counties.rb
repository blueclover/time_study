class CreateCounties < ActiveRecord::Migration
  def change
    create_table :counties do |t|
      t.string :name, null: false
    end
    add_index :counties, :name, unique: true
  end
end
