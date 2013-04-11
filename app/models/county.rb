class County < ActiveRecord::Base
	attr_accessible :name

  has_many :users, dependent: :restrict
  has_many :surveys, dependent: :restrict

  validates :name, presence: true, uniqueness: true
end
