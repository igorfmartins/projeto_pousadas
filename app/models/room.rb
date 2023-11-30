class Room < ApplicationRecord
    belongs_to :inn
    has_many :prices
    has_many :reservations
    has_many :ratings
    validates :name, :dimension, :bathroom, :max_occupancy, presence: true  
end