class DropModelsTable < ActiveRecord::Migration[7.1]
  def up
    drop_table :models
  end

  def down
    create_table :models do |t|
      t.string :email, default: "", null: false
      t.string :encrypted_password, default: "", null: false
      t.string :reset_password_token
      t.datetime :reset_password_sent_at
      t.datetime :remember_created_at
      t.timestamps null: false

      t.index :email, unique: true
      t.index :reset_password_token, unique: true
    end
  end
end
