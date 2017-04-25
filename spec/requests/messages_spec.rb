require 'rails_helper'

RSpec.describe 'Messages', type: :request do
  before { stub_authentication }

  it 'sends messages' do
    post '/messages', params: { user_ids: [1, 2, 3], messenger_types: ['telegram'], text: 'hello' }

    expect(response.status).to eq(200)
  end

  context 'when invalid params' do
    it 'returns errors' do
      post '/messages'

      response_json = JSON.parse(response.body)

      expect(response).to have_http_status(:unprocessable_entity)
      expect(response_json).to have_key('errors')
    end
  end
end
