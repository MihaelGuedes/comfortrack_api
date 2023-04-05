class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users, id: :uuid do |t|
      t.string :first_name, null: false, limit: 100
      t.string :last_name, null: false, limit: 100
      t.string :email, null: false, limit: 200
      t.string :user_type, null: false, limit: 100
      t.integer :status, default: 0, null: false
      t.string :password_digest, null: false
      t.string :password_reset_token
      t.string :avatar
      t.string :phone
      t.datetime :password_token_expiry

      t.timestamps
    end
    add_index :users, :email, unique: true
  end
end
