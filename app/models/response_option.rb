class ResponseOption < ActiveRecord::Base
  attr_accessible :description, :related_question, :parent_id, :activity_category_id

  belongs_to :activity_category
  belongs_to :parent, class_name: 'ResponseOption'
  has_many :children, class_name: 'ResponseOption', foreign_key: :parent_id

  validates :description, presence: true
  validates_numericality_of :related_question

  scope :for_question, 
  				->(question) { where("related_question = ?", "#{question}") }
end