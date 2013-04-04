class UserMoment < ActiveRecord::Base
  attr_accessible :user_id, :moment

  belongs_to :survey
  belongs_to :user
  has_one :response, dependent: :delete

  validates_presence_of [:user_id, :moment]

  scope :active, 
  				-> { where("moment < ? AND moment > ?", Time.zone.now, 5.days.ago) }

  scope :with_response, -> { joins(:response) }

  scope :with_no_response, ->
  				{ where("id not in (SELECT DISTINCT user_moment_id FROM responses)") }

  def user_responded?
  	!response.nil?
  end
end