class ActivityLog < ActiveRecord::Base
  attr_accessible :start_date

  belongs_to :survey
  belongs_to :user

  has_many :log_entries

  validates :user, presence: true
  validates :start_date, presence: true
end
