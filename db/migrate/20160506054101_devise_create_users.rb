class DeviseCreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      ## Database authenticatable
      t.string :email,              null: false
      t.string :encrypted_password, null: false

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      t.string :name,               null: false

      t.timestamps null: false
    end

    add_index :users, :name,                 unique: true
    add_index :users, :reset_password_token, unique: true
  end
end
