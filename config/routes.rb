Rails.application.routes.draw do
  resources :posts, only: [:new, :create]
  get "posts/index"
  devise_for :users
  root  "pages#home"
  get "/about", to: "pages#about" # /about で pages#about に、about_path ヘルパーも作成
  get "/timeline", to: "posts#index", as: :timeline # posts#indexは/timelineというURLに


  get "up" => "rails/health#show", as: :rails_health_check
end
