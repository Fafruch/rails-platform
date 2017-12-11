class UserOrganization < ApplicationRecord
  belongs_to :user
  belongs_to :organization

  enum organization_role: %i[organization_admin member]
end
