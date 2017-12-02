class AddMissingUserAttributes < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :city, :string
    add_column :users, :cuit, :string
  end
end
