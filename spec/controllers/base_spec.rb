# frozen_string_literal: true

describe 'base' do
  context 'when route not exist' do
    it 'returns an error in json format' do
      get '/fake_route'

      resp = MultiJson.load(last_response.body)
      expect(resp['error']).to eq 'Resource not found'
    end

    it 'returns a 400 if not a valid json' do
      invalid_json = '{'
      post '/ping', invalid_json
      expect(last_response.status).to be 400
    end

    it 'return a 404 error' do
      get 'fake/route'

      expect(last_response.status).to eq 404
    end

    it 'always return application/json header' do
      get '/fake_route'

      expect(last_response.headers['Content-Type']).to eq 'application/json'
    end

    it 'response to all origins' do
      get 'fake'

      expect(last_response.headers['Access-Control-Allow-Origin']).to eq '*'
    end

    it 'Accepts all REST verbs' do
      get 'fake'

      expect(last_response.headers['Access-Control-Allow-Methods'])
        .to eq 'GET, POST, PUT, DELETE, OPTIONS'
    end

    it 'response to options verb' do
      options '/ping'

      expect(last_response.status).to eq 200
    end
  end
end
