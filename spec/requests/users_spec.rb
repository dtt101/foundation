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
      get users_path(user)
      expect(response.content_type).to eq('application/json')
      expect(response).to have_http_status(200)
      json = JSON.parse(response.body)
      expect(json['data'].length).to eq(1)
    end
  end
end
