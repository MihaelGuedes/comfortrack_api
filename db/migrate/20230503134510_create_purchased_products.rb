class CreatePurchasedProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :purchased_products do |t|
      t.string :name
      t.decimal :price
      t.boolean :promotion
      t.integer :status
      t.integer :product_type
      t.references :product, null: false, foreign_key: true
      t.references :user, foreign_key: true, type: :uuid, index: true

      t.timestamps
    end
  end
end
