class CreatePayments < ActiveRecord::Migration[7.0]
  def change
    create_table :payments do |t|
      t.integer :type
      t.boolean :paid
      t.datetime :payday
      t.integer :status
      t.references :user, foreign_key: true, type: :uuid, index: true
      t.references :plan, null: false, foreign_key: true

      t.timestamps
    end
  end
end
