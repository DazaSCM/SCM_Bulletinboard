class PasswordResetController < ApplicationController
  def find_user
    @user = User.find_by(email: params[:email])
    if @user.present?
      PasswordMailer.with(user: @user).reset.deliver_later
      render json: {success: "Password Reset link is sent to your email"}
    else
      render json: {notice: "There is no user with this email"}
    end
  end

  def update_password 
    @user = User.find_signed!(params[:reset_token], purpose: "password reset")

    if @user.update_attribute(:password, params[:password])
      render json: {notice: "password changed succussfully"}
    else
      render json: {notice: "something went wrong, try again!"}
    end
  end
end
