class ProfilesController < ApplicationController
  # このコントローラーの全てのアクションの前に、ログインしているかを確認する
  before_action :authenticate_user!

  def edit
    # 編集対象として、自分自身（current_user）の情報を@user変数にセットする
    # これにより、edit.html.erbのフォームで@userを使えるようになります
    @user = current_user
  end

  def update
    # 更新対象として、自分自身（current_user）の情報を@user変数にセットする
    @user = current_user

    # フォームから送られてきた安全なデータ（profile_params）で、ユーザー情報を更新しようと試みる
    if @user.update(profile_params)
      # 更新に成功した場合
      redirect_to user_path(@user), notice: "プロフィールを更新しました！"
    else
      # 更新に失敗した場合（バリデーションエラーなど）
      # もう一度、編集ページを表示する
      render :edit, status: :unprocessable_entity
    end
  end

  private

  # ストロング・パラメータ
  # フォームから、:nameと:bioというキーを持つデータだけを受け取ることを許可する
  def profile_params
    params.require(:user).permit(:name, :bio)
  end
end