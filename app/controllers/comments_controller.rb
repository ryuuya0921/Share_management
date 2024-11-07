class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_plaza_post

  def create
    @comment = @plaza_post.comments.build(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_to plaza_post_path(@plaza_post), notice: 'コメントが追加されました。'
    else
      redirect_to plaza_post_path(@plaza_post), alert: 'コメントを追加できませんでした。'
    end
  end

  def destroy
    @comment = @plaza_post.comments.find(params[:id])
    if @comment.user == current_user
      @comment.destroy
      redirect_to plaza_post_path(@plaza_post), notice: 'コメントが削除されました。'
    else
      redirect_to plaza_post_path(@plaza_post), alert: 'コメントを削除する権限がありません。'
    end
  end

  private

  def set_plaza_post
    @plaza_post = PlazaPost.find(params[:plaza_post_id])
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end
