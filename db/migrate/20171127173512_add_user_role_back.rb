class AddUserRoleBack < ActiveRecord::Migration[5.1]
  def change
    change_table :users do |t|
      t.integer :role, default: 1
    end

    change_table :user_organizations do |t|
      t.integer :organization_role, default: 1
    end

    remove_column :user_organizations, :role
  end
end
