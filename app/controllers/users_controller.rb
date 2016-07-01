class UsersController < ApplicationController
  layout 'modal'

  def new
    @user = User.new
  end

  def create
    @user = User.new(allowed_params)
    
    if @user.save
      redirect_to articles_path, flash: { notice: 'User was successfully subscribed.' }
    else
      @user.errors.add(:email, 'is invalid')
      render :new
    end
  end

  private

  def allowed_params
    params.require(:user).permit(:email, :first_name, :last_name, :active)
  end
end
