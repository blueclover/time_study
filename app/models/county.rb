class County < ActiveRecord::Base
  has_many :users
  has_many :surveys
end
