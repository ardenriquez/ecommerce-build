class Order < ApplicationRecord
  STATUSES = %w[pending_payment pending_delivery paid cancelled].freeze
  PAYMENT_METHODS = %w[cash_on_delivery gcash credit_card].freeze

  belongs_to :user
  belongs_to :shop
  has_many :ordered_items, dependent: :destroy

  validates :total_in_cents, presence: true, numericality: { greater_than: 0 }
  validates :status, inclusion: { in: STATUSES }
  validates :payment_method, inclusion: { in: PAYMENT_METHODS }

  scope :pending_payment, -> { where(status: 'pending_payment') }
  scope :pending_delivery, -> { where(status: 'pending_delivery') }
  scope :paid, -> { where(status: 'paid') }
  scope :cancelled, -> { where(status: 'cancelled') }

  def total
    total_in_cents / 100.0
  end
end
