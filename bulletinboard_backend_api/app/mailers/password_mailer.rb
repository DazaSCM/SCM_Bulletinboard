class PasswordMailer < ApplicationMailer
  def reset
    @user = params[:user]
    @reset_token = @user.signed_id(purpose: "password reset", expires_in: 30.minutes)
    puts "token created-- #{@reset_token}"
    mail to: @user.email
  end
end
