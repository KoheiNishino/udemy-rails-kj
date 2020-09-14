Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # root：最初のルーティングを定義する
  root 'home#index'

  # 明示的なルーティング指定
  get 'mypage', to: 'users#me'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  # リソースベースルーティング：コントローラーの7つのアクションをまとめて定義する
  # resource：単数形リソースを使用してルーティングを定義
  # resources：複数形リソースを使用してルーティングを定義
  # only：必要なルーティングのみに絞る
  resources :users, only: %i[new create update]
  resources :boards
  resources :comments, only: %i[create destroy]
end
