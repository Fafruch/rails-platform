class UserOrganization < ApplicationRecord
  belongs_to :user
  belongs_to :organization

  enum organization_role: %i[org_admin member]

  # delegate :name, to: :organization
end
