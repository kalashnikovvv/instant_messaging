module MessengerAccounts
  class Registrator
    attr_reader :messenger_type, :recipient, :registration_code

    def initialize(messenger_type, recipient, registration_code)
      @messenger_type = messenger_type
      @recipient = recipient
      @registration_code = registration_code
    end

    def call
      return unless user

      account = MessengerAccount.find_or_initialize_by(user_id: user.id, messenger_type: messenger_type)
      account.recipient = recipient
      account.save!
    end

    def user
      @user ||= User.find_by(registration_code: registration_code)
    end
  end
end
