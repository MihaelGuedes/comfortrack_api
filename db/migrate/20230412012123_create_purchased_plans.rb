class CreatePurchasedPlans < ActiveRecord::Migration[7.0]
  def change
    create_table :purchased_plans do |t|
      t.string :name
      t.decimal :price
      t.integer :type_plan
      t.references :user, foreign_key: true, type: :uuid, index: true
      t.boolean :promotion

      t.timestamps
    end
  end
end
