class FollowsController < ApplicationController
  before_action :authenticate_user!

  def create
    user = User.find(params[:id])
    current_user.following << user
    redirect_to request.referer || user_path(user), notice: "#{user.name} をフォローしました！"
  end

  def destroy
    user = User.find(params[:id])
    current_user.following.delete(user)
    redirect_to request.referer || user_path(user), notice: "#{user.name} のフォローを解除しました！"
  end
end
