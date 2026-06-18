FactoryBot.define do
  factory :user do
    email { Faker::Internet.unique.email }
    role { 'customer' }
  end

  trait :admin do
    role { 'admin' }
  end
end