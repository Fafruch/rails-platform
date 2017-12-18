class Organization < ApplicationRecord
  has_many :user_organizations
  has_many :users, through: :user_organizations
  has_many :interest_types

  validates :name,
            :subdomain,
            presence: true,
            uniqueness: true
end
