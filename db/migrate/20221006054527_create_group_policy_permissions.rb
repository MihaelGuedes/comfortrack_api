class CreateGroupPolicyPermissions < ActiveRecord::Migration[7.0]
  def change
    create_table :group_policy_permissions do |t|
      t.references :permission, null: false, foreign_key: true
      t.references :group_policy, null: false, foreign_key: true

      t.timestamps
    end
  end
end
