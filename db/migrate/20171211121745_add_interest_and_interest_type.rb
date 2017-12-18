class AddInterestAndInterestType < ActiveRecord::Migration[5.1]
  def change
    create_table :interest_types do |t|
      t.belongs_to :organization, index: true
      t.string :name
    end
    create_table :interests do |t|
      t.belongs_to :interest_types, index: true
      t.belongs_to :user, index: true
      t.string :name
    end
  end
end
