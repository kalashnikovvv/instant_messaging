class MessagesBatch
  include ActiveModel::Model
  include Virtus.model

  attribute :messenger_types, Array[String]
  attribute :user_ids, Array[Integer]
  attribute :text, String
  attribute :send_at, DateTime

  validates :text, :user_ids, :messenger_types, presence: true
end
