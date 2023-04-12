class AddMonthsToPlan < ActiveRecord::Migration[7.0]
  def change
    add_column :plans, :months, :integer
    add_column :purchased_plans, :months, :integer
    add_reference :purchased_plans, :plan, foreign_key: true
  end
end
