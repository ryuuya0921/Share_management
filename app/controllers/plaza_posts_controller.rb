class PlazaPostsController < ApplicationController
  before_action :authenticate_user!

  def index
    @plaza_posts = PlazaPost.order(created_at: :desc).page(params[:page]).per(10)
  end

  def show
    @plaza_post = PlazaPost.find(params[:id])
  end

  def new
    @plaza_post = PlazaPost.new
  end

  def create
    @plaza_post = current_user.plaza_posts.build(plaza_post_params)
    if @plaza_post.save
      redirect_to plaza_posts_path, notice: '投稿が作成されました。'
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def plaza_post_params
    params.require(:plaza_post).permit(:title, :content)
  end
end
