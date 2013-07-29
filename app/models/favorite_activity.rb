class FavoriteActivity < ActiveRecord::Base
  attr_accessible :activity_category_id

  belongs_to :user
  belongs_to :county
  belongs_to :job_classification
  has_many :activity_categories

end