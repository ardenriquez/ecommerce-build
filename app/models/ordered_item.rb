class OrderedItem < ApplicationRecord
  belongs_to :order
  belongs_to :product

  validates :quantity, presence: true, numericality: { greater_than: 0 }
  validates :unit_price_in_cents, presence: true, numericality: { greater_than: 0 }
  validates :total_price_in_cents, presence: true, numericality: { greater_than: 0 }

  def total_price
    total_price_in_cents / 100.0
  end
end
