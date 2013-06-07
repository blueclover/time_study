class LogEntry < ActiveRecord::Base
  attr_accessible :date, :hours, :activities_attributes

  belongs_to :activity_log
  has_many :activities

  accepts_nested_attributes_for :activities

  validates :activity_log_id, presence: true
  validates :date, presence: true
  validates_numericality_of :hours
  validates_uniqueness_of :date, scope: :activity_log_id


  def total_hours
  	activities.sum(:hours) || "unpaid time off"
  end

  def build_activities
  	ActivityCategory.order(:id).each do |category|
  		activities.build(activity_category_id: category.id, hours: 0)
  	end
  end
end
