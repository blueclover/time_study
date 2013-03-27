class Response < ActiveRecord::Base
  attr_accessible :activity_category_id, 
  								:q1selection, :q2selection, :q3selection,
  								:q1text, :q2text, :q3text

  belongs_to :user_moment
  belongs_to :activity_category

	validates_numericality_of [:q1selection, :q2selection, :q3selection]
  validates_presence_of [:q1text, :q2text, :q3text]
end