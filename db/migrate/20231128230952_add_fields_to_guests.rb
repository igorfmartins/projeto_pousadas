class AddFieldsToGuests < ActiveRecord::Migration[7.1]
  def change
    add_column :guests, :full_name, :string
    add_column :guests, :cpf, :string
  end
end
