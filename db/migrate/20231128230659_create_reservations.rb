class CreateReservations < ActiveRecord::Migration[7.1]
  def change
    create_table :reservations do |t|
      t.date :start_date
      t.date :end_date
      t.integer :number_of_guests
      t.string :status
      t.references :room, null: false, foreign_key: true
      t.integer :guest_id
      t.string :pre_status
      t.string :confirmation_code
      t.integer :inn_id
      t.boolean :active_stay
      t.datetime :checkin_datetime

      t.timestamps
    end
  end
end
