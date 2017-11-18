class AddUserRoles < ActiveRecord::Migration[5.1]
  def change
    change_table :users do |t|
      t.integer :role, default: 1
    end
  end
end
