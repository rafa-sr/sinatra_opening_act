# frozen_string_literal: true

describe 'ping' do
  describe 'GET' do
    it 'respond pong' do
      get '/ping'

      expect(last_response.body).to eq 'pong'
    end

    it 'returns 200' do
      get '/ping'

      expect(last_response.status).to be 200
    end
  end
end
