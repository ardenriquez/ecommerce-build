FactoryBot.define do
  factory :cart do
    association :user
    status { 'active' }
    expires_at { 1.week.from_now }

    trait :active do
      status { 'active' }
    end

    trait :checked_out do
      status { 'checked_out' }
    end
  end
end
