class Cart < ApplicationRecord
  STATUSES = %w[active checked_out].freeze

  belongs_to :user

  validates :expires_at, presence: true
  validates :status, inclusion: { in: STATUSES }
  validates :user_id, uniqueness: { scope: :status, if: -> { active? } }

  scope :active, -> { where(status: 'active') }
  scope :checked_out, -> { where(status: 'checked_out') }

  def active?
    status == 'active'
  end

  def expired?
    expires_at < Time.current
  end

  def checkout!
    update!(status: 'checked_out')
  end
end
