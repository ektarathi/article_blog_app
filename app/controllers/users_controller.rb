class UsersController < ApplicationController
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(allowed_params)
    
    if @user.save

      puts "calling mail functionlity"
      puts @user

      redirect_to articles_path, flash: { notice: 'User was successfully subscribed.' }
    else
      render 'new'
    end
  end

  private

  def allowed_params
    params.require(:user).permit(:email, :first_name, :last_name, :active)
  end
end
