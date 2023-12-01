class AddCheckoutDatetimeToReservations < ActiveRecord::Migration[7.1]
  def change
    add_column :reservations, :checkout_datetime, :datetime
  end
end
