class User < ApplicationRecord 
  validates :email, presence: true, uniqueness: true
  has_one :inn
  has_many :reservations, through: :inn

  def has_inn?
    inn.present?
  end

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable  
end

