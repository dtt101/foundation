class UsersController < ApplicationController
  include ActionController::HttpAuthentication::Token::ControllerMethods

  TOKEN = ENV.fetch('AUTH_TOKEN')

  before_action :authenticate, only: :destroy
  before_action :set_user, only: [:show, :destroy]

  # GET /users
  def index
    @users = User.all

    render json: @users
  end

  # GET /users/1
  def show
    render json: @user
  end

  # POST /users
  def create
    @user = User.new(user_params)

    if @user.save
      render json: @user, status: :created, location: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:data).require(:attributes).permit(:username, :email, :password, :password_confirmation)
  end

  def authenticate
    authenticate_or_request_with_http_token do |token, _options|
      ActiveSupport::SecurityUtils.secure_compare(
        ::Digest::SHA256.hexdigest(token),
        ::Digest::SHA256.hexdigest(TOKEN)
      )
    end
  end
end
