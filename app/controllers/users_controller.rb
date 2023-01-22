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
      user_link
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to root_path, notice: t('controllers.users.destroyed')
  end

  private

  def user_link
    if @user.doctor?
      redirect_to @user.doctor_profile, notice: t('controllers.users.updated')
    else
      redirect_to @user.patient_profile, notice: t('controllers.users.updated')
    end
  end

  def set_current_user
    @user = current_user
  end

  def user_params
    params.require(:user).permit(:username, :email, :phone_number, :type, :image, pictures: [])
  end
end
