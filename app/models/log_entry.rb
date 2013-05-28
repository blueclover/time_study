class LogEntry < ActiveRecord::Base
  attr_accessible :date, :activities_attributes

  belongs_to :activity_log
  has_many :activities, dependent: :delete_all

  accepts_nested_attributes_for :activities

  validates :date, presence: true
  validates_uniqueness_of :date, scope: :activity_log_id


  def total_hours
  	activities.sum(:hours)
  end

  def build_activities
  	ActivityCategory.order(:code).each do |category|
  		activities.build(activity_category_id: category.id, hours: 0)
  	end
  end
end
