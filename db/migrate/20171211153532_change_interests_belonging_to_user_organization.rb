class ChangeInterestsBelongingToUserOrganization < ActiveRecord::Migration[5.1]
  def change
    drop_table :interests
    create_table :interests do |t|
      t.belongs_to :interest_type, index: true
      t.belongs_to :user_organization, index: true
      t.string :name
    end
  end
end
