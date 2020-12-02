require 'rails_helper'
require 'json'
RSpec.describe '/items', type: :request do
  before :each do
    @user = User.create!(name: 'Marshall', email: 'uimarshall@gmail.com', password: '12345678', nickname: 'crisBros')

    post '/api/v1/auth', params: { email: @user.email, password: '12345678' }
  end

  describe 'GET /items' do
    it 'returns an empty array if there is no item in the database' do
      get items_url

      expect(JSON.parse(response.body)).to eq([])
    end

    it 'returns an array with the items in the database' do
      img = fixture_file_upload('files/photo.jpg', 'image/jpg')
      params = { name: 'Hello!', description: 'Hello!', price: '44', usedFor: 'Lunch', user_id: @user.id, image: img }
      post items_url, params: params

      get items_url

      expect(JSON.parse(response.body).length).to eq(1)
    end
  end

  describe 'GET /items/:id' do
    it 'returns an error message if not found' do
      expect do
        post item_url(999)
      end.to raise_error(ActionController::RoutingError)
    end

    it 'returns the element if found' do
      img = fixture_file_upload('files/photo.jpg', 'image/jpg')
      params = { name: 'Hello!', description: 'Hello!', price: '44', usedFor: 'Lunch', user_id: @user.id, image: img }
      post items_url, params: params
      item = JSON.parse(response.body)

      get "/items/#{item[:id]}/"
      resp = JSON.parse(response.body)
      expect(resp[0]['name']).to eq('Hello!')
    end
  end

  describe 'POST /items' do
    context 'with valid parameters' do
      it 'creates a new Item' do
        expect do
          img = fixture_file_upload('files/photo.jpg', 'image/jpg')
          params = { name: 'Hello!', description: 'Hello!', price: '44', usedFor: 'Lu', user_id: @user.id, image: img }
          post items_url, params: params
        end.to change(Item, :count).by(1)
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Item' do
        expect do
          post items_url, params: { name: 'John DOe' }
        end.to change(Item, :count).by(0)
      end
    end
  end

  describe 'POST /items/:id/favorite' do
    it 'does not work if there is not authenticated_api_user whis is active only when using the API' do
      img = fixture_file_upload('files/photo.jpg', 'image/jpg')
      params = { name: 'Hello!', description: 'Hello!', price: '44', usedFor: 'Lunch', user_id: @user.id, image: img }
      post items_url, params: params
      item = JSON.parse(response.body)

      put "/items/#{item['id']}/favorite", params: { type: 'favorite' }
      resp = JSON.parse(response.body)

      expect(resp['errors'][0]).to eq('You need to sign in or sign up before continuing.')
    end
  end

  describe 'DELETE /items/:id' do
    it 'does not work if not signed in, cannot sign in due to rails using authenticated_api_user in the controller' do
      img = fixture_file_upload('files/photo.jpg', 'image/jpg')
      params = { name: 'Hello!', description: 'Hello!', price: '44', usedFor: 'Lunch', user_id: @user.id, image: img }
      post items_url, params: params
      item = JSON.parse(response.body)

      delete "/items/#{item['id']}/"

      expect(Item.first).to be_truthy
    end
  end
end
