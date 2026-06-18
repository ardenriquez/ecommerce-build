FactoryBot.define do
  factory :product do
    association :shop
    name { Faker::Commerce.product_name }
    sku { Faker::Code.isbn }
    price_in_cents { Faker::Number.between(from: 100, to: 10_000) }
    stock_quantity { Faker::Number.between(from: 0, to: 100) }
    status { 'available' }

    trait :available do
      status { 'available' }
    end

    trait :out_of_stock do
      status { 'out_of_stock' }
    end

    trait :discontinued do
      status { 'discontinued' }
    end
  end
end
