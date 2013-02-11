class LogEntry < ActiveRecord::Base
  attr_accessible :date

  belongs_to :activity_log
  has_many :activities

  validates :date, presence: true
end
