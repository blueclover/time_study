class Survey < ActiveRecord::Base
  attr_accessible :description, :name, :county_id,
  							 :create_with_logs, :default_start_date

  belongs_to :county
  has_many :user_moments, dependent: :destroy
  has_many :responses, through: :user_moments

  validates :name, presence: true
  validates :county_id, presence: true

  attr_reader :create_with_logs, :default_start_date

  def create_with_logs=(value)
    @create_with_logs = ActiveRecord::ConnectionAdapters::Column.value_to_boolean(value)
  end

  def default_start_date=(value)
    @default_start_date = value.to_date
  end

  after_create :create_logs

  def summary_table
    activities.joins(:activity_category).sum(:hours, group: :activity_category)
  end

  private

  
  	def create_logs
  		if create_with_logs
  			users = User.where(county_id: county_id)
  			if date = default_start_date
  				users.each do |user|
  					log = self.activity_logs.build(start_date: date)
  					log.user = user
  					log.save!
  					log.create_log_entries
  				end
  			else
  				users.each do |user|
  					log = self.activity_logs.build()
  					log.user = user
  					log.unconfirmed = true 
  					log.save!
  				end
  			end
  		end
  	end
end
