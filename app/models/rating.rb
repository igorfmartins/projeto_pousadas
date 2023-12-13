class Rating < ApplicationRecord
  belongs_to :reservation
  has_one :user_response
  validates :rating, :review, presence: true
  
end
  