class UsersController < ApplicationController
  before_action :authorize_request, except: :login

  def login
    @user = User.find_by(email: params[:email])
    if @user && @user.authenticate(params[:password])
      token = JsonWebToken.encode(user_id: @user.id)
      time = Time.now + 24.hours.to_i
      render json: { token: token, exp: time.strftime("%m-%d-%Y %H:%M"),
                     username: @user.name, id: @user.id, user_type: @user.user_type }, status: :ok
    else
      render json: { errors: { 'email or password' => ['is invalid'] } }, status: :unprocessable_entity
    end
  end

  def index
    @users = User.all
    render json: @users, methods: [:image_url]
  end

  def search
    @users = User.where(name: params[:name])
    if @users
      render json: @users, methods: [:image_url]
    else
      render json: {error: "User Not Found"}
    end
  end

  def create
    @user = User.create(user_params)
    if @user
      render json: @user, methods: [:image_url]
    else
      render json: @user.errors, status: unprocessable_entity
    end 
  end

  def show
    @user = User.find(params[:id])
    render json: @user, methods: [:image_url]
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      render json: @user, methods: [:image_url]
    else
      render json: @user.errors, status: unprocessable_entity
    end 
  end

  def destroy 
    @user = User.find(params[:id])
    @user = @user.destroy
    render json: @user, status: :ok
  end

  def change_password
    @user = User.find(params[:id])
    if @user.authenticate(params[:current_password])
      @is_update_password = @user.update_attribute(:password, params[:new_password ])
      render json: {message: "Change password successfully"}
    else
      render json: {errors: "Invalid Current Password"}, status: :unprocessable_entity
    end
  end

  private
    def user_params
      params.permit(:name, :email, :password, :profile, :user_type, :phone, :address, :dob, :created_user_id)
    end
end
