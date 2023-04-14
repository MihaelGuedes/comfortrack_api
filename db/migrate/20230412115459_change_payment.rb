class ChangePayment < ActiveRecord::Migration[7.0]
  def change
    add_column :payments, :due_date, :date
    add_column :payments, :card_holder, :string
    add_column :payments, :card_number, :string
    add_column :payments, :expiration_month, :string
    add_column :payments, :expiration_year, :string
    add_column :payments, :security_code, :string # protected
  end
end
