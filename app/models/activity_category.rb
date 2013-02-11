class ActivityCategory < ActiveRecord::Base
  attr_accessible :discount, :name

  has_many :activities
end
