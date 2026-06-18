class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :product

  validates :quantity, numericality: { greater_than: 0 }
  validates :unit_price_in_cents, numericality: { greater_than: 0 }
  validates :total_price_in_cents, numericality: { greater_than: 0 }

  before_save :calculate_total_price

  private

  def calculate_total_price
    self.total_price_in_cents = quantity * unit_price_in_cents
  end
end
