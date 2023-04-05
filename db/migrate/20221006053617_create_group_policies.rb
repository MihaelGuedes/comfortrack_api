class CreateGroupPolicies < ActiveRecord::Migration[7.0]
  def change
    create_table :group_policies do |t|
      t.string :name
      t.integer :user_type

      t.timestamps
    end
    add_index :group_policies, :user_type
  end
end
