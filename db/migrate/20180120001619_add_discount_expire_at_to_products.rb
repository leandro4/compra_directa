class AddDiscountExpireAtToProducts < ActiveRecord::Migration[5.1]
  def change
    add_column :products, :discount_expire_at, :date
  end
end
