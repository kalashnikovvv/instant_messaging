class MessengerAccount < ApplicationRecord
  belongs_to :user

  validates :user_id, uniqueness: { scope: :messenger_type }
end
