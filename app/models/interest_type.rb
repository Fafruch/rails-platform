class InterestType < ApplicationRecord
  belongs_to :organization
  has_many :interests, dependent: :destroy

  validates :name,
            :organization, presence: true
end
