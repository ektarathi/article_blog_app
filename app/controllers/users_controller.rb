class UsersController < ApplicationController
  layout 'modal'

  before_action :set_user, only: [:unsubscribe]

  def new
    @user = User.new
  end

  def create
    @user = User.new(allowed_params)
    
    if @user.save
      flash[:notice] = 'User was successfully subscribed.'
      redirect_to_js root_path 
    else
      @user.errors.add(:email, 'is invalid')
      render :new
    end
  end

  def unsubscribe
    @user.update_attribute(:active,false)
    flash[:notice] = 'User was successfully unsubscribed.'
    redirect_to root_path
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def allowed_params
    params.require(:user).permit(:email, :first_name, :last_name, :active)
  end
end
