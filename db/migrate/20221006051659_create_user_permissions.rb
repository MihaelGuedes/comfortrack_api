class CreateUserPermissions < ActiveRecord::Migration[7.0]
  def change
    create_table :user_permissions, id: :uuid do |t|
      t.references :user, null: false, foreign_key: true, index: true, type: :uuid
      t.references :permission, null: false, foreign_key: true, index: true

      t.timestamps
    end
  end
end
