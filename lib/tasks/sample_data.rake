namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    populate_table('counties', false)
    populate_table('job_classifications', false)
    populate_table('activity_categories')
    populate_table('response_options')
    make_users
    make_surveys
  end
end

def make_users
  admin = User.new(#name:     "Example User",
                       email:    "admin@county.org",
                       password: "password",
                       password_confirmation: "password")
  admin.admin = true
  admin.save!
  counties = County.all(limit: 2)
  jobs = JobClassification.all
  counties.each do |county|
    staff_count = 1
    jobs.each do |job|
      staff_count.times do |n|
        #name  = Faker::Name.name
        email = "#{job.name.parameterize}_#{n+1}@#{county.name.parameterize}.org"
        password  = "password"
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
    county.surveys.create!(name: "#{county.name} Survey Mar 2013",
                           start_date: 30.days.ago,
                           end_date: 0.days.ago,
                           sample_size: 100)
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

  if field_names.include?('id')
    sql = "WITH mx AS ( SELECT MAX(id) AS id FROM public.response_options) " +
        "SELECT setval('public.response_options_id_seq', mx.id) AS curseq " +
        "FROM mx;"
    ActiveRecord::Base.connection.execute(sql)
  end
end