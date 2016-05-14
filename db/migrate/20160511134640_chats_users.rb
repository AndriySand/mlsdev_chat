class ChatsUsers < ActiveRecord::Migration
  def change
    create_table :chats_users do |t|
      t.integer :chat_id, null: false
      t.integer :user_id, null: false

      t.timestamps null: false
    end
  end
end
