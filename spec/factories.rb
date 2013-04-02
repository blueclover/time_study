FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "foo#{n}@county.org" }
    password "password"
    password_confirmation "password"

    county
    job_classification

    factory :admin do
      admin true
    end
  end

  factory :survey do
    sequence(:name) { |n| "Example survey #{n}" }
    county
    start_date 1.day.from_now
    end_date 30.days.from_now
    sample_size 4
  end

  factory :county do
    sequence(:name) { |n| "County #{n}" }
  end

  factory :job_classification do
    sequence(:name) { |n| "Job #{n}" }
  end
end