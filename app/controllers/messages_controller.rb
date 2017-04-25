class MessagesController < ApplicationController
  def create
    messages_batch = MessagesBatch.new(messages_batch_params)

    if messages_batch.valid?
      MessagesBatches::Sender.new(messages_batch).call
      head :ok
    else
      render json: { errors: messages_batch.errors }, status: :unprocessable_entity
    end
  end

  private

  def messages_batch_params
    params.permit(:text, :send_at, user_ids: [], messenger_types: [])
  end
end
