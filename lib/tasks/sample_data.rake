namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    populate_table('counties', false)
    populate_table('job_classifications', false)
    populate_table('activity_categories')
    make_users
    make_surveys
    make_activity_logs
    make_log_entries
  end
end

def make_users
  password  = "password"
  admin = User.new(#name:     "Example User",
                       email:    "admin@county.org",
                       password: password,
                       password_confirmation: password)
  admin.admin = true
  admin.save!

  user = County.first.users.build(email: "user@alameda.org",
                            password: password,
                            password_confirmation: password,
                            job_classification_id: 1)
  user.authentication_token = "user_token"
  user.save!

  counties = County.all(limit: 2)
  jobs = JobClassification.all
  counties.each do |county|
    staff_count = 1
    jobs.each do |job|
      staff_count.times do |n|
        #name  = Faker::Name.name
        email = "#{job.name.parameterize}_#{n+1}@#{county.name.parameterize}.org"
        
        user = county.users.build(#name:     name,
                                  email:    email,
                                  password: password,
                                  password_confirmation: password)
        user.job_classification = job
        user.save!
      end
      staff_count *= 3
    end    
  end
end

def make_surveys
  counties = County.all(limit: 10)
  counties.each do |county|
    county.surveys.create!(name: "#{county.name} Survey Feb 2013",
                           start_date: start_date)
  end
end

def make_activity_logs
  surveys = Survey.all
  # date = Date.commercial(Date.today.year, Date.today.cweek, 1)
  surveys.each do |survey|
    users = User.where(county_id: survey.county.id)
    users.each_with_index do |user, n|
      log = survey.activity_logs.build(start_date: start_date)
      log.user = user
      log.save!
    end
  end
end

def make_log_entries
  date_range = (start_date..(Date.today - 2.days)).reject{ |d| d.saturday? || d.sunday? }
  activity_logs = ActivityLog.all
  activity_logs.each do |log|
    date_range.each do |date|
      entry = log.log_entries.create!(date: date)
      ActivityCategory.order(:code).each do |activity|
        hours = rand(40)/4.0 - 7
        hours = 0 if hours < 0
        entry.activities.create!(activity_category_id: activity.id, hours: hours)
      end
    end
  end
end

def start_date
  Date.parse('20130501')
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