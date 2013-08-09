class LogEntry < ActiveRecord::Base
  attr_accessible :date, :hours, :activities_attributes

  belongs_to :activity_log
  has_many :activities

  delegate :user, to: :activity_log

  accepts_nested_attributes_for :activities

  validates :activity_log_id, presence: true
  validates :date, presence: true
  validates_numericality_of :hours
  validates_uniqueness_of :date, scope: :activity_log_id

  validate :sum_hours_not_more_than_total_hours

  def sum_hours
    activities.sum(:hours)
  end

  def build_activities    
    ActivityCategory.order(:id).each do |category|
      activities.build(activity_category_id: category.id, hours: 0)
    end
  end

  def activity_ids_with_hours
    activities_with_hours = activities.where("hours > 0")
    activities_with_hours.map(&:activity_category_id) if activities_with_hours
  end

  private
  def sum_hours_not_more_than_total_hours
    unless self.activities.map(&:hours).sum <= hours
      errors.add(:hours, "Sum of activity hours cannot exceed total hours worked")
    end
  end
end
