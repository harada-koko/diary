class CommentsController < ApplicationController
  before_action :set_post, only: [:create]

  def create
    # 段階1: 内容と投稿場所を持ったコメントを準備
    @comment = @post.comments.build(comment_params)
    # 段階2: そのコメントに、作者の情報を追加
    @comment.user = current_user

    if @comment.save
      redirect_to timeline_path, notice: 'コメントを投稿しました！'
    else
      # TODO: エラー時の処理を後で改善する
      redirect_to timeline_path, alert: 'コメントの投稿に失敗しました。'
    end
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end