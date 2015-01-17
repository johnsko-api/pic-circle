require 'factory_girl'

FactoryGirl.define do
  factory :user do
    sequence(:email) {|n| "user#{n}@example.com" }
    display_name 'display name'
    password 'password'
    password_confirmation 'password'
  end

  factory :circle do
    title "Round circle"
    description "This circle is the best"
    is_private false
    user
  end

end
