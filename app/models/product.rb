class Product < ApplicationRecord
  STATUSES = %w[available out_of_stock discontinued].freeze

  belongs_to :shop

  validates :name, presence: true
  validates :sku, presence: true
  validates :price_in_cents, presence: true
  validates :stock_quantity, presence: true
  validates :status, presence: true, inclusion: { in: STATUSES }
  validates :sku, uniqueness: { scope: :shop_id }

  before_validation :strip_name

  scope :available, -> { where(status: 'available') }
  scope :out_of_stock, -> { where(status: 'out_of_stock') }
  scope :discontinued, -> { where(status: 'discontinued') }

  def in_stock?
    stock_quantity > 0
  end

  def available?
    status == 'available' && in_stock?
  end

  def price
    price_in_cents / 100.0
  end

  private

  def strip_name
    self.name = name.strip if name.present?
  end
end
