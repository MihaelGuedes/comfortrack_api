class ChangeUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :cep, :string
    add_column :users, :city, :string
    add_column :users, :address, :string
    add_column :users, :neighborhood, :string
    add_column :users, :complement, :string
    add_column :users, :gender, :integer
    add_column :users, :birth_date, :date
  end
end
