class CreateQuestions < ActiveRecord::Migration[5.1]
  def change
    create_table :questions, id: :uuid do |t|
      t.string :question
      t.string :answer
      t.uuid :commerce_id
      t.uuid :product_id
      t.datetime :answered_at
      t.timestamps
    end

    add_index :questions, :commerce_id
    add_index :questions, :product_id
  end
end
