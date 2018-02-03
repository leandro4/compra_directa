class AddAcceptedAtToOrders < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :accepted_at, :datetime
  end
end
