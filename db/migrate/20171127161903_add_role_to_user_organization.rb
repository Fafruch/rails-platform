class AddRoleToUserOrganization < ActiveRecord::Migration[5.1]
  def change
    remove_column :users, :role

    change_table :user_organizations do |t|
      t.integer :role, default: 2
    end
  end
end
