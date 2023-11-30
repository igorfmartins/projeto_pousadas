class RenameOwnerResponseToUserResponse < ActiveRecord::Migration[7.1]
  def change
    rename_table :owner_responses, :user_responses
  end
end
