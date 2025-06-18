class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @posts = @user.posts.order(created_at: :desc) # ユーザーの投稿を新しい順に取得
    @likes = @user.likes.includes(:post).order(created_at: :desc) # ユーザーのいいねを新しい順に取得
    @liked_posts = @user.liked_posts.order('likes.created_at DESC')
     @commented_posts = @user.comments.includes(:post).map(&:post).uniq
  end

  def index
    @users = User.all
  end

end
