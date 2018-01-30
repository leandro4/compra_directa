class Product < ApplicationRecord
  belongs_to :provider

  has_many :questions

  validates :name, presence: true
  validates :description, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :discount_price, presence: true, numericality: { greater_than_or_equal_to: 0 }, if: Proc.new { is_discount }
  validates_numericality_of :discount_price, less_than: Proc.new { |product| product.price }, if: Proc.new { is_discount }
  validates :discount_expire_at, presence: true, if: Proc.new { is_discount }

  scope :active_discount, -> { where(is_discount: true).where("discount_expire_at >= ?", Time.zone.today) }
  scope :expired_discount, -> { where(is_discount: true).where("discount_expire_at < ?", Time.zone.today) }

  def has_discount
    is_discount && discount_expire_at > Time.zone.now
  end
end
