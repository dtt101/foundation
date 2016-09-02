require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'GET /users' do
    let!(:users) { FactoryGirl.create_list(:user, 10) }

    it 'lists users' do
      get users_path
      expect(response.content_type).to eq('application/json')
      expect(response).to have_http_status(200)
      json = JSON.parse(response.body)
      expect(json['data'].length).to eq(10)
    end
  end

  describe 'GET /users/1' do
    let(:user) { FactoryGirl.create(:user) }

    it 'gets a single user' do
      get user_path(user)
      expect(response.content_type).to eq('application/json')
      expect(response).to have_http_status(200)
      json = JSON.parse(response.body)
      expect(json['data'].length).to eq(3)
      expect(json['data']['attributes'].length).to eq(2)
    end
  end

  describe 'POST /users' do
    let(:valid_json_api_attributes) {
      {
        data: {
          type: 'users',
          attributes: {
            username: 'foo',
            email: 'foo@example.com',
            password: 'password',
            password_confirmation: 'password'
          }
        }
      }
    }

    it 'creates a new user' do
      post users_path, params: valid_json_api_attributes, as: :json
      expect(response).to have_http_status(201)
    end
  end

  describe 'DELETE /users/1' do
    let(:user) { FactoryGirl.create(:user) }

    it 'deletes an existing user' do
      delete user_path(user), headers: { 'HTTP_AUTHORIZATION' => 'Token token="test_token"' }
      expect(response).to have_http_status(204)
    end
  end
end
