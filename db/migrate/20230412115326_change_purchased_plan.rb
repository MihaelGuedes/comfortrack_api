class ChangePurchasedPlan < ActiveRecord::Migration[7.0]
  def change
    add_column :purchased_plans, :status, :integer
    add_column :purchased_plans, :due_date, :date
  end
end
