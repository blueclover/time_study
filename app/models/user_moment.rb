class UserMoment < ActiveRecord::Base
  attr_accessible :user_id, :moment

  belongs_to :user
  has_one :response, dependent: :delete

  validates_presence_of [:user_id, :moment]

  def user_responded?
  	!response.nil?
  end
end