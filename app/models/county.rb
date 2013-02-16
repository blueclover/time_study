class County < ActiveRecord::Base
  has_many :users
  has_many :surveys

  validates :name, presence: true, uniqueness: true
end
