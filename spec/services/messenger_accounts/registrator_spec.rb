require 'rails_helper'

RSpec.describe MessengerAccounts::Registrator do
  let!(:user) { create(:user) }

  context 'when messenger account doesnt exist' do
    it 'create messenger account' do
      expect {
        described_class.new('telegram', '123', user.registration_code).call
      }.to change { MessengerAccount.count }.by(1)

      messenger_account = MessengerAccount.last

      expect(messenger_account.recipient).to eq('123')
      expect(messenger_account.user_id).to eq(user.id)
    end
  end

  context 'when messenger account exists' do
    let!(:messenger_account) { create(:messenger_account, recipient: '543', user: user) }

    it 'update recipient' do
      expect {
        described_class.new('telegram', '123', user.registration_code).call
      }.to_not change { MessengerAccount.count }

      messenger_account.reload

      expect(messenger_account.recipient).to eq('123')
      expect(messenger_account.user_id).to eq(user.id)
    end
  end
end
