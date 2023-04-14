class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders, id: :uuid do |t|
      t.references :product, null: false, foreign_key: true
      t.references :user, foreign_key: true, type: :uuid, index: true
      t.string :tracking_code
      t.integer :status

      t.timestamps
    end
  end
end
