class Room < ApplicationRecord
    belongs_to :inn
    has_many :prices
    has_many :reservations
    validates :name, :dimension, :bathroom, :max_occupancy, presence: true  
end