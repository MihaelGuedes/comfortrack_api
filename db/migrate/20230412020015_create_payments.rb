class CreatePayments < ActiveRecord::Migration[7.0]
  def change
    create_table :payments do |t|
      t.integer :type
      t.boolean :paid
      t.datetime :payday
      t.integer :status
      t.references :user, foreign_key: true, type: :uuid, index: true

      t.timestamps
    end
  end
end
