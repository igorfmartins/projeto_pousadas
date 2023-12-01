class AddRoomIdToRatings < ActiveRecord::Migration[7.1]
  def change
    add_reference :ratings, :room, null: false, foreign_key: true
  end
end
