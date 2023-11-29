class CreatePrices < ActiveRecord::Migration[7.1]
  def change
    create_table :prices do |t|
      t.date :start_date
      t.date :end_date
      t.decimal :daily_rate
      t.references :room, null: false, foreign_key: true

      t.timestamps
    end
  end
end
