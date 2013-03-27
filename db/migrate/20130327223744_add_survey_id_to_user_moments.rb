class AddSurveyIdToUserMoments < ActiveRecord::Migration
  def change
    add_column :user_moments, :survey_id, :integer
    add_index :user_moments, :survey_id
  end
end
