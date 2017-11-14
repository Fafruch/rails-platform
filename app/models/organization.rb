class Organization < ApplicationRecord
  has_many :users, through: :user_organizations
end
