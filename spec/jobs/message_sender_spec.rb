require 'rails_helper'

RSpec.describe MessageSender do
  let(:user) { create(:user) }
  let!(:messenger_account) do
    create(:messenger_account,
           user: user,
           messenger_type: :telegram,
           recipient: '145386813',
           last_message: 'last')
  end

  it 'does nothing when message duplicate last message' do
    result = described_class.perform_now(user_id: user.id, messenger_type: 'telegram', text: 'last')

    expect(result).to eq(false)
  end

  it 'sends message' do
    VCR.use_cassette 'messengers/telegram' do
      result = described_class.perform_now(user_id: user.id, messenger_type: 'telegram', text: 'hello')

      messenger_account.reload

      expect(result).to eq(true)
      expect(messenger_account.last_message).to eq('hello')
    end
  end
end
