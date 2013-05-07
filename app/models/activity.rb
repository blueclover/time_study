class Activity < ActiveRecord::Base
  attr_accessible :activity_category_id, :hours

  belongs_to :log_entry
  belongs_to :activity_category

  delegate :code, :name, to: :activity_category

end
