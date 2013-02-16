class Survey < ActiveRecord::Base
  attr_accessible :description, :name, :county_id,
  							 :create_with_logs, :default_start_date

  belongs_to :county
  has_many :activity_logs, dependent: :destroy

  validates :name, presence: true
  validates :county_id, presence: true

  attr_accessor :create_with_logs, :default_start_date

  after_create :create_logs

  private
  	def create_logs
  		if create_with_logs
  			users = User.where(county_id: county_id)
  			if date = default_start_date.to_date
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
