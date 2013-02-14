class Survey < ActiveRecord::Base
  attr_accessible :description, :name

  belongs_to :county
  has_many :activity_logs, dependent: :destroy

  validates :name, presence: true
end
