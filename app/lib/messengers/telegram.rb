require 'telegram/bot'

module Messengers
  class Telegram
    def send_message(recipient:, text:)
      api.send_message(chat_id: recipient, text: text)
    end

    private

    def api
      @api ||= ::Telegram::Bot::Client.run(ENV['TELEGRAM_API_TOKEN']) { |c| c.api }
    end
  end
end
