class RemovePreStatusFromReservations < ActiveRecord::Migration[7.1]
  def change
    remove_column :reservations, :pre_status, :string
  end
end
