class UserOrganization < ApplicationRecord
  belongs_to :user
  belongs_to :organization
  has_many :interests, dependent: :destroy

  enum organization_role: %i[organization_admin member]
end
