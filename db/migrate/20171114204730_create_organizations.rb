class CreateOrganizations < ActiveRecord::Migration[5.1]
  def change
    create_table :user_organizations do |t|
      t.belongs_to :user, index: true
      t.belongs_to :organization, index: true
    end

    create_table :organizations do |t|
      t.string :name
    end
  end
end
