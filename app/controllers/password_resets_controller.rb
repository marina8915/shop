class PasswordResetsController < ApplicationController
  before_action :set_categories_filters

  include CurrentCart
  before_action :set_cart

  def create
    user = User.find_by_email(params[:email])
    user.send_password_reset if user
    redirect_to root_path, notice: 'E-mail sent with password reset instructions.'
  end

  def edit
    @user = User.find_by_password_reset_token!(params[:id])
  end

  def update
    @user = User.find_by_password_reset_token!(params[:id])
    if @user.password_reset_sent_at < 2.hour.ago
      redirect_to new_password_reset_path, alert: 'Password reset has expired.'
    elsif @user.update(user_params)
      redirect_to new_session_path, notice: 'Password has been reset!'
    else
      render 'edit'
    end
  end

  private

  def user_params
    params.require(:user).permit(:password)
  end
end