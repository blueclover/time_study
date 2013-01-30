class Survey < ActiveRecord::Base
  attr_accessible :description, :name

  has_many :activity_logs

  validates :name, presence: true
end
