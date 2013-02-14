namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    make_counties
    make_activity_categories
    make_users
    make_surveys
    make_activity_logs
    make_log_entries
  end
end

def make_counties
  populate_table('counties', false)
end

def make_activity_categories
  populate_table('activity_categories')
end

def make_users
  admin = User.new(#name:     "Example User",
                       email:    "admin@county.org",
                       password: "password",
                       password_confirmation: "password")
  admin.save!
  admin.toggle!(:admin)
  counties = County.all(limit: 2)
  counties.each do |county|
    5.times do |n|
      #name  = Faker::Name.name
      email = "probation_officer_#{n+1}@#{county.name.downcase}.org"
      password  = "password"
      county.users.create!(#name:     name,
                     email:    email,
                     password: password,
                     password_confirmation: password)
    end
  end
end

def make_surveys
  counties = County.all(limit: 10)
  counties.each do |county|
    county.surveys.create!(name: "#{county.name} Survey Feb 2013")
  end
end

def make_activity_logs
  surveys = Survey.all
  surveys.each do |survey|
    users = User.where(county_id: survey.county.id)
    users.each_with_index do |user, n|
      date = Date.commercial(Date.today.year, n + 2, 1)
      log = survey.activity_logs.build(start_date: date)
      log.user = user
      log.save!
    end
  end
end

def make_log_entries
  activity_logs = ActivityLog.all
  activity_logs.each do |log|
    5.times do |n|
      date = n.days.since(log.start_date).to_date
      entry = log.log_entries.create!(date: date)
      ActivityCategory.order(:code).each do |activity|
        entry.activities.create!(activity_category: activity)
      end
    end
  end
end

def populate_table(table, timestamps=true)
  file_path = "setup/#{table}.csv"
  field_names = CSV.parse(File.open(file_path, &:readline))[0]

  timestamp_fields = ''
  timestamp_values = ''
  if timestamps
    created_at = Time.now.strftime("%Y-%m-%d %H:%M:%S")
    timestamp_fields = ", created_at, updated_at"
    timestamp_values = ", '#{created_at}', '#{created_at}'"
  end

  CSV.foreach(file_path, {headers: :first_row}) do |row|
    sql_vals = []

    field_names.each do |column|
      val = row[column]
      sql_vals << ActiveRecord::Base.connection.quote(val)
    end

    sql = "INSERT INTO #{table} " +
        "(#{field_names.join(',')}#{timestamp_fields}) " +
        "VALUES " +
        "(#{sql_vals.join(',')}#{timestamp_values})"
    ActiveRecord::Base.connection.insert(sql)
  end
end