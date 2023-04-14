class CreateCollars < ActiveRecord::Migration[7.0]
  def change
    create_table :collars, id: :uuid do |t|
      t.string :name
      t.string :last_latitude
      t.string :last_longitude
      t.references :user, foreign_key: true, type: :uuid, index: true

      t.timestamps
    end
  end
end
