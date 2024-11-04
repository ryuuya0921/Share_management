class LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_votable

  def like
    current_user.likes(@votable)
    redirect_back fallback_location: root_path, notice: 'いいねしました。'
  end

  def unlike
    current_user.unlike(@votable)
    redirect_back fallback_location: root_path, notice: 'いいねを取り消しました。'
  end

  private

  def find_votable
    @votable = Post.find(params[:id])
  end
end
