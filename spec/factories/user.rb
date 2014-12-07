FactoryGirl.define do
  factory :user do
    sequence(:username) { |n| "ikstrm#{n}" }
    password "password"
    password_confirmation "password"
    name "いくす"
    year 2011
    repeated_year 0
    grade 4
    bio "よろしくお願いします！"
    profile "弐寺やってます"
  end
end
