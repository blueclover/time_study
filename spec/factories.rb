FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "foo#{n}@county.org" }
    password "password"
    password_confirmation "password"
  end

  factory :survey do
    sequence(:name) { |n| "Example survey #{n}" }
  end

  factory :activity_log do
  	survey
  	user
    start_date 3.days.ago
  end
end