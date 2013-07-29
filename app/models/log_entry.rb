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


  def total_hours
  	activities.sum(:hours) || "unpaid time off"
  end

  def build_activities(show_all)
    
    if show_all
      categories = ActivityCategory.order(:id).map(&:id)
    else
      categories = user.favorite_activities
    end
    
    categories.each do |category|
  		activities.build(activity_category_id: category, hours: 0)
  	end
  end
end
