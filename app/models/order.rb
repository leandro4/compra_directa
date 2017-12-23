class Order < ApplicationRecord
  PENDING = "pending"
  ACCEPTED = "accepted"
  REJECTED = "rejected"
  STATUSES = [PENDING, ACCEPTED, REJECTED]

  belongs_to :commerce
  belongs_to :provider

  has_many :order_items, dependent: :destroy

  before_create :set_pending

  def accept!
    update(status: ACCEPTED)
  end

  def reject!
    update(status: REJECTED)
  end

  private

  def set_pending
    self.status = PENDING unless self.status
  end
end
