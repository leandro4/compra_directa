class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users, id: :uuid do |t|
    	t.string :email
    	t.string :password_digest
    	t.string :first_name
    	t.string :last_name
      t.string :phone
      t.string :address
      t.string :category
      t.string :user_type
    	t.timestamps
	    end
  end
end
