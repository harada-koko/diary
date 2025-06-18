class PostsController < ApplicationController
  # 追記：投稿機能はログイン必須にする
  before_action :authenticate_user!

  def index
    if params[:type].present?
       # もしURLにtypeパラメータが存在したら、その種類で投稿を絞り込む
      @posts = Post.where(post_type: params[:type]).order(created_at: :desc)
    else
      # パラメータがなければ、全ての投稿を対象にする
      @posts = Post.all.order(created_at: :desc)
    end

    @character=Character.order("RANDOM()").first
    @liked_posts = current_user.likes.includes(:post).map(&:post)
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to cheer_path, notice: "投稿が作成されました！"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
    @post = current_user.posts.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to post_path(@post), notice: "投稿が更新されました！"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @post = current_user.posts.find(params[:id])
    @post.destroy
    redirect_to timeline_path, notice: '投稿を削除しました。', status: :see_other, status: :see_other
  end

  private

  def post_params
    params.require(:post).permit(:content, :post_type)
  end

end