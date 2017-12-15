class ChangeNamesToBusinessNameInUsers < ActiveRecord::Migration[5.1]
  def change
    remove_column :users, :first_name
    remove_column :users, :last_name
    add_column :users, :business_name, :string
  end
end
