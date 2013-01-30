class ActivityLog < ActiveRecord::Base
  belongs_to :survey
  attr_accessible :staff_id, :start_date

  validates :staff_id, presence: true
  validates :start_date, presence: true
end
