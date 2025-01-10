class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find(params[:id])
  end

  def followers
    @user = User.find(params[:id])
    @followers = @user.followers.page(params[:page]).per(5)
  end

  def following
    @user = User.find(params[:id])
    @following = @user.following.page(params[:page]).per(5)
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user

    if @user.guest? && params[:user][:name].present?
      flash[:alert] = 'ゲストユーザーは名前の変更を行えません。'
      redirect_to edit_user_path(@user) and return
    end

    if @user.update(user_params)
      redirect_to profile_path(@user), notice: 'プロフィールが更新されました。'
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :bio, :remove_profile_image)
  end
end
