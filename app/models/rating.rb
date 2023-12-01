class Review < ApplicationRecord
    belongs_to :reservation
    has_one :user_response
    validates :rating, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 5 }
    validates :review_text, presence: true
  end
  