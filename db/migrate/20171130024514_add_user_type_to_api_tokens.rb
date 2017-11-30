class AddUserTypeToApiTokens < ActiveRecord::Migration[5.1]
  def change
    add_column :api_tokens, :user_type, :string
  end
end
