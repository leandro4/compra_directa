class CreateApiTokens < ActiveRecord::Migration[5.1]
  def change
    create_table :api_tokens, id: :uuid do |t|

      t.uuid :user_id
      t.string :token
      t.datetime :expire_at
      t.timestamps null: false
    end

    add_index :api_tokens, :user_id
  end
end
