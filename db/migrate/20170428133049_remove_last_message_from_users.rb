class RemoveLastMessageFromUsers < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :last_message, :string
  end
end
