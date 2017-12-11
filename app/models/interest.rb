class Interest < ApplicationRecord
  belongs_to :interest_type
  belongs_to :user_organization

  validates :name, presence: true
end
