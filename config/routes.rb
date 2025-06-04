Rails.application.routes.draw do
  root "pages#home"  # トップページをpagesコントローラーのhomeアクションに設定
  get "/about", to: "pages#about", as: :about # /about で pages#about に、about_path ヘルパーも作成

  # (中略) 他のルーティング ...

  get "up" => "rails/health#show", as: :rails_health_check
end
