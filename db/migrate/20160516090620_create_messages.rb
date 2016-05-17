class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.text :body
      t.integer :author_id
      t.integer :chat_id

      t.timestamps null: false
    end
  end
end
