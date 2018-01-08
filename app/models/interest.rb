class Interest < ApplicationRecord
  belongs_to :interest_type
  belongs_to :user_organization

  validates :name,
            :interest_type,
            :user_organization, presence: true
end
