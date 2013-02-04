FactoryGirl.define do
  factory :survey do
    name "Foo"
  end

  factory :user do
    sequence(:email) { |n| "foo#{n}@county.org" }
    password "password"
    password_confirmation "password"
  end
end