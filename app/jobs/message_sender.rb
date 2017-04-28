class MessageSender < ApplicationJob
  include ActiveJob::Retry.new(strategy: :constant, limit: 3, delay: 1.minutes)

  def perform(options)
    messenger_account = find_messenger_account(options[:user_id], options[:messenger_type])

    messanger = get_messenger(options[:messenger_type])
    messanger.send_message(recipient: messenger_account.recipient, text: options[:text])
  end

  private

  def find_messenger_account(user_id, messenger_type)
    MessengerAccount.find_by!(user_id: user_id, messenger_type: messenger_type)
  end

  def get_messenger(messenger_type)
    "Messengers::#{messenger_type.classify}".constantize.new
  end
end
