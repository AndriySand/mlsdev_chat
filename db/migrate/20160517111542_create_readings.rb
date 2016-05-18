class CreateReadings < ActiveRecord::Migration
  def change
    create_table :readings do |t|
      t.integer :message_id, null: false
      t.integer :user_id, null: false

      t.timestamps null: false
    end

    add_index :readings, [:message_id, :user_id], unique: true
  end
end
