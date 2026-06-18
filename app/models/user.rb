class User < ApplicationRecord
  ROLES = %w[customer admin].freeze

  has_many :carts

  validates :role, inclusion: { in: ROLES }
  validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: URI::MailTo::EMAIL_REGEXP }

  before_validation :downcase_email

  def admin?
    role == "admin"
  end

  def customer?
    role == "customer"
  end

  private

  def downcase_email
    self.email = email.downcase.strip if email.present?
  end
end
