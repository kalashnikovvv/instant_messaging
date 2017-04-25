require 'rails_helper'

RSpec.describe 'Authenctication', type: :request do
  context 'without auth token' do
    it 'returns status 401' do
      post '/messages'

      expect(response).to have_http_status(:unauthorized)
    end
  end

  context 'with auth token' do
    it 'doesnt return status 401' do
      post '/messages', headers: { 'Authorization': "Token token=\"#{ENV['AUTH_TOKEN']}\"" }

      expect(response).to_not have_http_status(:unauthorized)
    end
  end
end
