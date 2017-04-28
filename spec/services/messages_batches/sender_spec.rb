require 'rails_helper'

RSpec.describe MessagesBatches::Sender do
  let(:user) { create(:user) }

  let(:messages_batch) { MessagesBatch.new(user_ids: [user.id], messenger_types: ['telegram'], text: 'hello') }
  let(:messages_batch2) { MessagesBatch.new(user_ids: [user.id], messenger_types: ['telegram'], text: 'duplicatable') }

  before(:all) { ActiveJob::Base.queue_adapter = :test }

  context 'when message is unique' do
    it 'sends message' do
      expect {
        described_class.new(messages_batch).call
      }.to have_enqueued_job(MessageSender)
    end
  end

  context 'when message isnt unique' do
    it 'does nothing' do
      expect {
        described_class.new(messages_batch2).call
      }.to have_enqueued_job(MessageSender)

      expect {
        described_class.new(messages_batch).call
      }.to have_enqueued_job(MessageSender)

      expect {
        described_class.new(messages_batch2).call
      }.to_not have_enqueued_job(MessageSender)
    end
  end
end
