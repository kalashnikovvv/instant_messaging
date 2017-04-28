require 'rails_helper'

RSpec.describe MessagesBatches::Sender do
  let(:user) { create(:user, last_message: 'last') }

  let(:messages_batch) { MessagesBatch.new(user_ids: [user.id], messenger_types: ['telegram'], text: text) }
  let(:result) { described_class.new(messages_batch).call }

  before(:all) { ActiveJob::Base.queue_adapter = :test }

  context 'when message duplicates last message' do
    let(:text) { 'last' }

    it 'does nothing' do
      expect { result }.to_not have_enqueued_job(MessageSender)
    end
  end

  context 'when message doesnt duplicate last message' do
    let(:text) { 'hello' }

    it 'sends message' do
      expect { result }.to have_enqueued_job(MessageSender)
    end
  end
end
