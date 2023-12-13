class Price < ApplicationRecord
  belongs_to :room
  validates :start_date, :end_date, :daily_rate, presence: true
  validate :no_date_overlap
  
end


