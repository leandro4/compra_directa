class AddRegistrationIdToApiTokens < ActiveRecord::Migration[5.1]
  def change
    add_column :api_tokens, :registration_id, :string
  end
end
