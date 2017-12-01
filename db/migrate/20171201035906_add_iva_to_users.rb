class AddIvaToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :iva, :string
  end
end
