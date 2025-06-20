# config/routes.rb

Rails.application.routes.draw do
  get "comments/create"
  # 1. Devise (ユーザー認証) のルート
  # これが /users/sign_in や /users/sign_up などのURLを全て定義します
  devise_for :users

  # 2. アプリケーションの「玄関」となるルート
  # ログインしていないユーザーが最初に訪れるページ
  root "pages#home"

  # 3. 静的なページへのルート
  get "/about", to: "pages#about"
  get "/cheer", to: "cheers#show" # 応援ページ

  # 4. 投稿と、それに関連する機能のルート
  # 投稿の一覧は /timeline で表示する
  get "/timeline", to: "posts#index", as: :timeline

  # 投稿の作成、編集、更新、削除のルートを定義
  # ただし、一覧表示の /posts は /timeline と重複するので除外 (except: :index)
  # 詳細表示の /posts/:id も、今回は使わないので除外します
  resources :posts, except: [:index] do
    # 投稿にネスト（入れ子に）する形で、「いいね」のルートを定義
    # これにより /posts/:post_id/likes というURLが作られます
    resources :likes, only: [:create, :destroy]
    resources :comments, only: [:create, :destroy, :edit, :update] 
  end

   # 5. ユーザー関連のルート
  resources :users, only: [:show,:index] # ユーザー詳細ページ

  resource :profile, only: [:edit, :update]

  # 6. Rails標準のヘルスチェック用ルート
  # アプリが正常に起動しているかを外部から確認するために使われます
  get "up" => "rails/health#show", as: :rails_health_check
end