class CreateOrderItems < ActiveRecord::Migration[5.1]
  def change
    create_table :order_items, id: :uuid do |t|
      t.float :unit_price
      t.integer :quantity
      t.uuid :order_id
      t.uuid :product_id

      t.timestamps
    end

    add_index :order_items, :order_id
    add_index :order_items, :product_id
  end
end
