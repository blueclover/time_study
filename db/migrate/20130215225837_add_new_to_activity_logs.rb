class AddNewToActivityLogs < ActiveRecord::Migration
  def change
    add_column :activity_logs, :unconfirmed, :boolean, default: false
  end
end
