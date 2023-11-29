class CreateRooms < ActiveRecord::Migration[7.1]
  def change
    create_table :rooms do |t|
      t.string :name
      t.text :description
      t.float :dimension
      t.integer :max_occupancy
      t.decimal :daily_rate
      t.boolean :bathroom
      t.boolean :balcony
      t.boolean :air_conditioning
      t.boolean :tv
      t.boolean :wardrobe
      t.boolean :safe
      t.boolean :accessible
      t.boolean :available
      t.references :inn, null: false, foreign_key: true

      t.timestamps
    end
  end
end
