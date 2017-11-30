class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products, id: :uuid do |t|
      t.string :name
      t.string :description
      t.float :price
      t.float :discount_price
      t.boolean :is_discount, default: false

      t.uuid :provider_id
      t.timestamps
    end

    add_index :products, :provider_id
  end
end
