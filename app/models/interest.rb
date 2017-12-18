class Interest < ApplicationRecord
  belongs_to :interest_type
  belongs_to :user
end
