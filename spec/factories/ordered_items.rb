FactoryBot.define do
  factory :ordered_item do
    association :order
    association :product
    name { Faker::Commerce.product_name }
    sku { Faker::Code.isbn }
    quantity { 1 }
    unit_price_in_cents { 10_000 }
    total_price_in_cents { 10_000 }
  end
end
