class LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post # createとdestroyの前に、対象の投稿を@postにセットする

  def create
    # current_user.likes.build で、user_idが自動でセットされたLikeインスタンスが作られる
    @like = @post.likes.build(user: current_user)

    if @like.save
      redirect_to timeline_path, notice: 'いいねしました！'
    else
      redirect_to timeline_path, alert: 'いいねに失敗しました。'
    end
  end

  def destroy
    # current_user.likes の中から、対象の投稿のいいねを探して削除する
    @like = @post.likes.find_by(user: current_user)
    @like.destroy
    redirect_to timeline_path, notice: 'いいねを取り消しました。', status: :see_other
  end

  private

  # createとdestroyで共通の「投稿を見つける処理」をまとめる
  def set_post
    @post = Post.find(params[:post_id])
  end
end