class AddStatusToRatings < ActiveRecord::Migration[7.1]
  def change
    add_column :ratings, :status, :string
  end
end
