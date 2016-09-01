require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  let(:valid_json_api_attributes) {
    {
      data: {
        type: 'users',
        attributes: {
          username: "foo",
          email: "foo@exammple.com",
          password: "password",
          password_confirmation: "password"
        }
      }
    }    
  }

  let(:invalid_json_api_attributes) {
    {
      data: {
        type: 'users',
        attributes: {
          username: "bar",
          email: "bar&exammple.com",
          password: "password",
          password_confirmation: "password"          
        }
      }
    }    
  }  

  let(:valid_attributes) {
    { username: 'foo', email: 'foo@example.com', password: 'foobar', password_confirmation: 'foobar' }
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # UsersController.
  let(:valid_session) { {} }

  describe "GET #index" do
    it "assigns all users as @users" do
      user = User.create! valid_attributes
      get :index, params: {}, session: valid_session
      expect(assigns(:users)).to eq([user])
    end
  end

  describe "GET #show" do
    it "assigns the requested user as @user" do
      user = User.create! valid_attributes
      get :show, params: {id: user.to_param}, session: valid_session
      expect(assigns(:user)).to eq(user)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new user" do
        expect {
          post :create, {
            params: valid_json_api_attributes
          }
        }.to change(User, :count).by(1)
      end

      it "assigns a newly created user as @user" do
        post :create, params: valid_json_api_attributes, session: valid_session
        expect(assigns(:user)).to be_a(User)
        expect(assigns(:user)).to be_persisted
      end

      it "returns a 201 status code" do
        post :create, params: valid_json_api_attributes, session: valid_session
        expect(response.status).to eq(201)
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved user as @user" do
        post :create, params: invalid_json_api_attributes, session: valid_session
        expect(assigns(:user)).to be_a_new(User)
      end

      it "returns a 422 status code" do
        post :create, params: invalid_json_api_attributes, session: valid_session
        expect(response.status).to eq(422)
      end
    end
  end

  describe "DELETE #destroy" do

    it "returns a 401 status code if no token provided" do
      user = User.create! valid_attributes
      delete :destroy, params: {id: user.to_param}, session: valid_session
      expect(response.status).to eq(401)
    end    

    it "destroys the requested user" do
      #  TODO: move secret to env
      request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Token.encode_credentials("test_token")
      user = User.create! valid_attributes
      expect {
        delete :destroy, params: {id: user.to_param}, session: valid_session
      }.to change(User, :count).by(-1)
    end

    it "returns a 204 status code" do
      request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Token.encode_credentials("test_token")
      user = User.create! valid_attributes
      delete :destroy, params: {id: user.to_param}, session: valid_session
      expect(response.status).to eq(204)
    end
  end

end
