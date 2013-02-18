class JobClassification < ActiveRecord::Base
  has_many :users, dependent: :restrict

  validates :name, presence: true, uniqueness: true
end
