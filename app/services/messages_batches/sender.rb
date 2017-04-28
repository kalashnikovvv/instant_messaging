module MessagesBatches
  class Sender
    attr_reader :messages_batch

    def initialize(messages_batch)
      @messages_batch = messages_batch
    end

    def call
      messages_batch.users.each do |user|
        next if user.last_message == messages_batch.text
        user.update_column(:last_message, messages_batch.text)

        messages_batch.messenger_types.each do |messenger_type|
          sender = MessageSender
          sender = sender.set(wait_until: messages_batch.send_at) if messages_batch.send_at
          sender.perform_now(
            user_id: user.id,
            messenger_type: messenger_type,
            text: messages_batch.text
          )
        end
      end
    end
  end
end
