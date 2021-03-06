class UserOrganization < ApplicationRecord
  belongs_to :user
  belongs_to :organization
  has_many :interests, dependent: :destroy

  delegate :first_name, :last_name, to: :user

  validates :user,
            :organization, presence: true

  enum organization_role: %i[organization_admin member]
end
