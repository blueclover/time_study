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

  def self.accessible_to(user)
    if user.admin?
      scoped
    else
      where(user_id: user.id)
    end
  end

  def new_log_entry_url(date)
    "/activity_logs/#{id}/log_entries/new?date=#{date.strftime('%Y%m%d')}"
  end

  def recent_log_entries
    first_date = Date.today - 1.month
    first_date = start_date if first_date < start_date

    days = (first_date..Date.today).reject{|d| d.saturday?||d.sunday?}.reverse

    days.map do |day|
      le = log_entries.where(date: day).first
      row = [day, id]
      if le
        row << le.id
        if le.hours > 0
          row + [le.total_hours]
        else
          row + ['unpaid time off']
        end
      else
        row + [day, 'no log entry']
      end
    end
  end

  def build_log_entry(date, default_hours)
    log_entries.new(date: date, hours: default_hours)
  end
  
  def create_log_entries
    date_range = (start_date..(Date.today - 2.days)).reject{ |d| d.saturday?||d.sunday? }
    date_range.each do |date|
      entry = log_entries.create!(date: date)
      ActivityCategory.order(:code).each do |category|
        entry.activities.create!(activity_category_id: category)
      end
    end
  end
end
