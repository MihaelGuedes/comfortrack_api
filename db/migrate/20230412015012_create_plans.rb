class CreatePlans < ActiveRecord::Migration[7.0]
  def change
    create_table :plans do |t|
      t.string :name
      t.decimal :price
      t.integer :type_plan

      t.timestamps
    end
  end
end
