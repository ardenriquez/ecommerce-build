FactoryBot.define do
  factory :cart_item do
    association :cart
    association :product
    quantity { 1 }
    unit_price_in_cents { 1_000 }
    total_price_in_cents { 1_000 }
  end
end
