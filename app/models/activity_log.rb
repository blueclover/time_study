class ActivityLog < ActiveRecord::Base
  attr_accessible :start_date

  belongs_to :survey
  belongs_to :user

  validates :user, presence: true
  validates :start_date, presence: true
end
