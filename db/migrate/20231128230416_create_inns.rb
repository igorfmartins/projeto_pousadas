class CreateInns < ActiveRecord::Migration[7.1]
  def change
    create_table :inns do |t|
      t.string :brand_name
      t.string :corporate_name
      t.integer :cnpj
      t.integer :contact_phone
      t.string :email
      t.string :full_address
      t.string :state
      t.string :city
      t.integer :zip_code
      t.text :description
      t.integer :rooms_max
      t.boolean :pets_accepted
      t.boolean :breakfast
      t.boolean :camping
      t.string :accessibility
      t.text :policies
      t.string :payment_methods
      t.time :check_in_time
      t.time :check_out_time
      t.boolean :active
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
