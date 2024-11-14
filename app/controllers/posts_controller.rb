class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  def index
    filtered_posts = load_posts_without_pagination
    @post_count = filtered_posts.count
    @posts = load_posts
  end

  def toggle_bookshelf_visibility
    current_user.update(bookshelf_public: !current_user.bookshelf_public)
    redirect_to posts_path, notice: '本棚の公開設定が更新されました。'
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

  def show
    @post = Post.find(params[:id])
  end

  def update
    if @post.update(post_params)
      redirect_to posts_path, notice: '投稿が更新されました'
    else
      render :edit
    end
  end

  private

  def load_posts
    posts = current_user.posts
    posts = filter_by_status(posts)
    posts = sort_posts(posts)
    filter_posts(posts).page(params[:page]).per(9)
  end

  def load_posts_without_pagination
    posts = current_user.posts
    posts = filter_by_status(posts)
    sort_posts(posts)
  end

  def filter_by_status(posts)
    case params[:status]
    when 'public' then posts.where(public: true)
    when 'private' then posts.where(public: false)
    else posts
    end
  end

  def sort_posts(posts)
    params[:sort] == 'oldest' ? posts.order(created_at: :asc) : posts.order(created_at: :desc)
  end

  def post_params
    params.require(:post).permit(:title, :body, :category, :genre, :image, :public)
  end

  def set_post
    @post = current_user.posts.find(params[:id])
  end

  def filter_posts(posts)
    posts = posts.where(public: true) if params[:public_only] == 'true'
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
      posts.where(
        'title LIKE ? OR body LIKE ?',
        "%#{params[:keyword]}%",
        "%#{params[:keyword]}%"
      )
    else
      posts
    end
  end
end
