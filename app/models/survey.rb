class Survey < ActiveRecord::Base
  attr_accessible :description, :name

  has_many :activity_logs, dependent: :destroy

  validates :name, presence: true
end
