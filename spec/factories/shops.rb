FactoryBot.define do
  factory :shop do
    name { Faker::Company.name }
    status { 'open' }

    trait :open do
      status { 'open' }
    end

    trait :closed do
      status { 'closed' }
    end

    trait :suspended do
      status { 'suspended' }
    end
  end
end
