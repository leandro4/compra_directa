class Order < ApplicationRecord
  PENDING = "pending"
  ACCEPTED = "accepted"
  REJECTED = "rejected"
  STATUSES = [PENDING, ACCEPTED, REJECTED]

  belongs_to :commerce
  belongs_to :provider

  has_many :order_items, dependent: :destroy

  before_create :set_pending

  scope :accepted, -> { where(status: ACCEPTED) }

  def total_price
    order_items.sum { |item| item.unit_price * item.quantity }
  end

  def accept!
    update(status: ACCEPTED, accepted_at: Time.zone.now)
  end

  def reject!
    update(status: REJECTED)
  end

  private

  def set_pending
    self.status = PENDING unless self.status
  end
end
