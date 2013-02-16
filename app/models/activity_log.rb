class ActivityLog < ActiveRecord::Base
  attr_accessible :start_date

  belongs_to :survey
  belongs_to :user

  has_many :log_entries, dependent: :destroy

  validates :user, presence: true
  validates :start_date, presence: true, unless: :unconfirmed

  def create_log_entries
  	5.times do |n|
      date = n.days.since(self.start_date).to_date
      entry = self.log_entries.create!(date: date)
      ActivityCategory.order(:code).each do |activity|
        entry.activities.create!(activity_category: activity)
      end
    end
  end
end
