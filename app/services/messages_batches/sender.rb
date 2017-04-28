module MessagesBatches
  class Sender
    attr_reader :messages_batch

    def initialize(messages_batch)
      @messages_batch = messages_batch
    end

    def call
      messages_batch.users.each do |user|
        next unless unique_message_for_user?(messages_batch.text, user)

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

    private

    def unique_message_for_user?(text, user)
      Redis.current.hsetnx("users:#{user.id}:messages", text, true)
    end
  end
end
