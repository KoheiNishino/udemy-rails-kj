Rails.application.routes.draw do
  # 単数形リソースを使用してルーティングを定義
  get 'mypage', to: 'users#me'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # root：最初のルーティングを定義する
  root 'home#index'
  # resourecs：コントローラーの7つのアクションをまとめて定義する
  # only：必要なルーティングのみに絞る
  resources :users, only: %i[new create]
  resources :boards
  resources :comments, only: %i[create destroy]
end
