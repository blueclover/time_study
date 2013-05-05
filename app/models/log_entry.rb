class LogEntry < ActiveRecord::Base
  attr_accessible :date, :activities_attributes, :signed

  belongs_to :activity_log
  has_many :activities, dependent: :delete_all

  accepts_nested_attributes_for :activities

  validates :date, presence: true

  validates :signed, acceptance: true

  def total_hours
  	activities.sum(:hours)
  end

end
