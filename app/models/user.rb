class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  validates :email,
            uniqueness: true,
            presence: true,
            format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i,
                      message: 'has a bad format' }
  validates :phone_number,
            presence: true,
            format: { with: /\A(\+48)?\s?\d{3}\s?\d{3}\s?\d{3}\z/,
                      message: 'has a bad format' }

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :user_organizations
  has_many :organizations, through: :user_organizations

  enum role: %i[global_admin user]
end