class PlazaPostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_plaza_post, only: [:show, :edit, :update, :destroy]

  def index
    @plaza_posts = PlazaPost.order(created_at: :desc)
    @plaza_posts = filter_by_keyword(@plaza_posts) # ここで検索を適用
    @plaza_posts = @plaza_posts.page(params[:page]).per(10)
  end

  def show
    @comments = @plaza_post.comments.order(created_at: :asc).page(params[:page]).per(10)
  end

  def edit
    redirect_to plaza_posts_path, alert: '編集する権限がありません。' unless @plaza_post.user == current_user
  end

  def update
    if @plaza_post.update(plaza_post_params)
      redirect_to plaza_post_path(@plaza_post), notice: '投稿が更新されました。'
    else
      render :edit, status: :unprocessable_entity
    end
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

  def destroy
    if @plaza_post.user == current_user
      @plaza_post.destroy
      redirect_to plaza_posts_path, notice: '投稿が削除されました。'
    else
      redirect_to plaza_posts_path, alert: '削除する権限がありません。'
    end
  end

  private

  def set_plaza_post
    @plaza_post = PlazaPost.find(params[:id])
  end

  def plaza_post_params
    params.require(:plaza_post).permit(:title, :content)
  end

  def filter_by_keyword(posts)
    if params[:search_word].present?
      posts.where(
        'title LIKE ? OR content LIKE ?',
        "%#{params[:search_word]}%",
        "%#{params[:search_word]}%"
      )
    else
      posts
    end
  end
end
