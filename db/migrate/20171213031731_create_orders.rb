class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders, id: :uuid do |t|
      t.string :status
      t.uuid :provider_id
      t.uuid :commerce_id

      t.timestamps
    end

    add_index :orders, :provider_id
    add_index :orders, :commerce_id
  end
end
