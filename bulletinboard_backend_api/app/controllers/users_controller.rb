class UsersController < ApplicationController
  before_action :authorize_request, except: :login

  def login
    @user = User.find_by(email: params[:email])
    if @user && @user.authenticate(params[:password])
      token = JsonWebToken.encode(user_id: @user.id)
      time = Time.now + 24.hours.to_i
      render json: { token: token, exp: time.strftime("%m-%d-%Y %H:%M"),
                     username: @user.email }, status: :ok
    else
      render json: { errors: { 'email or password' => ['is invalid'] } }, status: :unprocessable_entity
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      render json: @user, methods: [:image_url]
    else
      render json: @user.errors, status: 422
    end 
  end

  private
    def user_params
      params.permit(:name, :email, :password, :profile, :user_type, :phone, :address, :dob)
    end
end
