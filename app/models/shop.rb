class Shop < ApplicationRecord
  STATUSES = %w[open closed suspended].freeze

  has_many :products, dependent: :destroy

  validates :name, presence: true
  validates :status, presence: true, inclusion: { in: STATUSES }

  before_validation :strip_name

  scope :open, -> { where(status: "open") }
  scope :closed, -> { where(status: "closed") }
  scope :suspended, -> { where(status: "suspended") }

  def open?
    status == "open"
  end

  def suspended?
    status == "suspended"
  end

  private

  def strip_name
    self.name = name.strip if name.present?
  end
end
