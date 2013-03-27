class CreateUserMoments < ActiveRecord::Migration
  def change
    create_table :user_moments do |t|
      t.references :user
      t.datetime :moment

      t.timestamps
    end
    add_index :user_moments, :user_id
  end
end
