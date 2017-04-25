class CreateMessengerAccounts < ActiveRecord::Migration[5.0]
  def change
    create_table :messenger_accounts do |t|
      t.string :messenger_type
      t.string :recipient
      t.text :last_message
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
