class AddProductNameDescriptionToOrderItems < ActiveRecord::Migration[5.1]
  def change
    add_column :order_items, :product_name, :string
    add_column :order_items, :product_description, :string
  end
end
