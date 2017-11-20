class Organization < ApplicationRecord
  has_many :user_organizations
  has_many :users, through: :user_organizations

  validates :name,
            presence: true,
            uniqueness: true

  validates :subdomain,
            presence: true,
            uniqueness: true
end
