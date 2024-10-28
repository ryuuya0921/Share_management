class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  def index
    @posts = filter_posts(current_user.posts).page(params[:page]).per(9)
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to posts_path, notice: '投稿が作成されました。'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_path, notice: '投稿が削除されました。'
  end

  def edit; end

  def show; end

  def update
    if @post.update(post_params)
      redirect_to posts_path, notice: '投稿が更新されました'
    else
      render :edit
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :category, :genre, :image)
  end

  def set_post
    @post = current_user.posts.find(params[:id])
  end

  def filter_posts(posts)
    posts = filter_by_category(posts)
    posts = filter_by_genre(posts)
    filter_by_keyword(posts)
  end

  def filter_by_category(posts)
    params[:category].present? ? posts.where(category: params[:category]) : posts
  end

  def filter_by_genre(posts)
    params[:genre].present? ? posts.where(genre: params[:genre]) : posts
  end

  def filter_by_keyword(posts)
    if params[:keyword].present?
      posts.where('title LIKE ? OR body LIKE ?', "%#{params[:keyword]}%", "%#{params[:keyword]}%")
    else
      posts
    end
  end
end
