class InterestType < ApplicationRecord
  belongs_to :organization
  has_many :interests

  validates :name, presence: true
end
