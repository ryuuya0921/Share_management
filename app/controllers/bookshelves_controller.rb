class BookshelvesController < ApplicationController
  def index
    @bookshelves = User.includes(:posts).where.not(id: current_user.id).where(posts: { id: Post.select(:id) })
    @total_users = @bookshelves.count
    @bookshelves = filter_bookshelves(@bookshelves)
  end

  def show
    @user = User.find(params[:id])

    if @user.bookshelf_public || current_user == @user
      @bookshelf = filter_posts(@user.posts.where(public: true)).page(params[:page]).per(6)
    else
      redirect_to bookshelves_path, alert: 'このユーザーの本棚は非公開です。'
    end
  end

  def post_detail
    @user = User.find(params[:id])
    @post = Post.find(params[:post_id])
  end

  private

  def filter_bookshelves(users)
    users.joins(:posts).merge(filter_posts(Post.all)).distinct
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
