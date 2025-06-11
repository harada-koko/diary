class CheersController < ApplicationController
  before_action :authenticate_user! # ログイン必須

  def show
    # キャラクターをランダムに1体取得する
    @character = Character.order("RANDOM()").first
  end
end