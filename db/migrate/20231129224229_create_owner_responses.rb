class CreateOwnerResponses < ActiveRecord::Migration[7.1]
  def change
    create_table :owner_responses do |t|
      t.references :rating, null: false, foreign_key: true
      t.text :response

      t.timestamps
    end
  end
end
