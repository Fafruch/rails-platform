class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  validates :email,
            uniqueness: true,
            presence: true,
            format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i,
                      message: 'has bad format' }
  validates :phone_number,
            presence: true,
            format: { with: /\A(\+48)?\s?\d{3}\s?\d{3}\s?\d{3}\z/,
                      message: 'has bad format' }

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :organizations, through: :user_organizations
end