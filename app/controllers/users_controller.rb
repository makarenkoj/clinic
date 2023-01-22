class UsersController < ApplicationController
  before_action :authenticate_user!, except: %i[index]
  before_action :set_current_user

  def index
    @users = User.all
  end

  def show
    @user
  end

  def update
    if @user.update(user_params)
      redirect_to @user, notice: t('controllers.users.updated')
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to root_path, notice: t('controllers.users.destroyed')
  end

  private

  def set_current_user
    @user = current_user
  end

  def user_params
    params.require(:user).permit(:username, :email, :phone_number, :type, :image, pictures: [])
  end
end
