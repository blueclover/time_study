FactoryGirl.define do
  factory :survey do
    name "Foo"
  end

  factory :user do
    sequence(:email) { |n| "foo#{n}@example.com" }
    password "foobar"
  end
end