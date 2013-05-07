class Survey < ActiveRecord::Base
  attr_accessible :description, :name, :county_id, :start_date

  belongs_to :county
  has_many :activity_logs, dependent: :destroy
  has_many :log_entries, through: :activity_logs
  has_many :activities, through: :log_entries

  validates :name, presence: true
  validates :county_id, presence: true
  validates :start_date, presence: true

  after_create :create_logs

  def summary_table
    activities.joins(:activity_category).sum(:hours, group: :activity_category)
  end

  private
    def create_logs
      users = User.where(county_id: county_id).where(admin: false)
      users.each do |user|
        log = activity_logs.build(start_date: start_date)
        log.user = user
        log.save!
      end
    end
end
