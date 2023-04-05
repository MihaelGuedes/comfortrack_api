class CreateUserLoginLogs < ActiveRecord::Migration[7.0]
  def change
    create_table :user_login_logs do |t|
      t.datetime :last_login_at
      t.string :email
      t.string :user_agent
      t.string :ip_address
      t.references :user, foreign_key: true, type: :uuid, index: true

      t.timestamps
    end
  end
end
