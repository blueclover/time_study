class ActivityLog < ActiveRecord::Base
  attr_accessible :start_date

  belongs_to :survey
  belongs_to :user

  has_many :log_entries, dependent: :destroy
  has_many :activities, through: :log_entries

  validates :user, presence: true
  validates :start_date, presence: true, unless: :unconfirmed

  def summary_table
    activities.joins(:activity_category).sum(:hours, group: :activity_category)
  end

  def recent_log_entries
    first_date = Date.today - 1.month
    first_date = start_date if first_date < start_date

    days = (first_date..Date.today).reject{|d| d.saturday?||d.sunday?}.reverse

    days.map do |day|
      le = log_entries.where(date: day).first
      row = [day]
      if le 
        row + ["/activity_logs/#{id}/log_entries/#{le.id}", le.total_hours]
      else
        row + ["/activity_logs/#{id}/log_entries/new?date=#{day.strftime('%Y%m%d')}",
                'no log entry']
      end
    end
  end

  def build_log_entry(date)
    log_entries.new(date: date)
  end
  
  def create_log_entries
  	5.times do |n|
      date = n.days.since(self.start_date).to_date
      entry = log_entries.create!(date: date)
      ActivityCategory.order(:code).each do |category|
        entry.activities.create!(activity_category_id: category)
      end
    end
  end
end
