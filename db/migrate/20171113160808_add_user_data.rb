class AddUserData < ActiveRecord::Migration[5.1]
  def change
    change_table :users do |t|
      t.string :phone_number,            default: ""
      t.string :first_name, null: false, default: ""
      t.string :last_name,  null: false, default: ""
    end
  end
end
