class ChangeUserName < ActiveRecord::Migration[7.0]
  def change
    rename_column :users, :first_name, :name
    remove_column :users, :last_name
    change_column :users, :name, :string, null: false, limit: 100
  end
end
