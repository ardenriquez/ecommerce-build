FactoryBot.define do
  factory :order do
    association :user
    association :shop
    status { 'pending_payment' }
    payment_method { 'cash_on_delivery' }
    total_in_cents { 10_000 }

    trait :pending_payment do
      status { 'pending_payment' }
    end

    trait :pending_delivery do
      status { 'pending_delivery' }
    end

    trait :paid do
      status { 'paid' }
    end

    trait :cancelled do
      status { 'cancelled' }
    end
  end
end
