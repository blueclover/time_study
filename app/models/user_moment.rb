class UserMoment < ActiveRecord::Base
  attr_accessible :user_id, :moment

  belongs_to :survey
  belongs_to :user
  has_one :response, dependent: :delete

  validates_presence_of [:user_id, :moment]

  scope :active, -> do
  	where("moment < ? AND moment > ?", Time.zone.now, 5.days.ago)
  end

  scope :answered, -> { joins(:response) }

  scope :unanswered, -> do
  	where("id not in (SELECT DISTINCT user_moment_id FROM responses)")
  end

  def user_responded?
  	!response.nil?
  end
end