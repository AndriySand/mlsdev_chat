class CreateChats < ActiveRecord::Migration
  def change
    create_table :chats do |t|
      t.string :name, null: false

      t.timestamps null: false
    end

    add_index :chats, :name, unique: true
  end
end
