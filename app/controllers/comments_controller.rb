class CommentsController < ApplicationController
  # 変更点1: destroy, edit, update でも @post をセットするようにする
  before_action :set_post, only: [:create, :destroy, :edit, :update]
  # 変更点2: destroy, edit, update では @comment もセットするようにする
  before_action :set_comment, only: [:destroy, :edit, :update]

  def create
    @comment = @post.comments.build(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_to post_path(@post), notice: 'コメントを投稿しました！' # タイムラインより投稿詳細へのリダイレクトを推奨
    else
      redirect_to post_path(@post), alert: 'コメントの投稿に失敗しました。'
    end
  end

  # アクション内はこれだけでOK
  def destroy
    if @comment.destroy
      redirect_to post_path(@post), notice: 'コメントを削除しました。'
    else
      redirect_to post_path(@post), alert: 'コメントの削除に失敗しました。'
    end
  end

  def edit
  end

  def update
    if @comment.update(comment_params)
      redirect_to timeline_path, notice: 'コメントを更新しました。'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  # このメソッドは変更なし
  def set_post
    @post = Post.find(params[:post_id])
  end

  # 変更点3: @comment をセットするメソッドを新設
  def set_comment
    @comment = @post.comments.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end