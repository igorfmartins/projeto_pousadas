class AddTotalPaidToReservations < ActiveRecord::Migration[7.1]
  def change
    add_column :reservations, :total_paid, :decimal
  end
end
