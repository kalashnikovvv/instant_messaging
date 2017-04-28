class ReplaceLastMessageFromMessengerAccountsToUsers < ActiveRecord::Migration[5.0]
  def change
    remove_column :messenger_accounts, :last_message, :string
    add_column :users, :last_message, :string
  end
end
