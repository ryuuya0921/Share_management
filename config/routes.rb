Rails.application.routes.draw do
  get 'profiles/show'
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  resources :users, only: [:show, :edit, :update] # ユーザー専用ページ用のルートを定義
  resources :bookshelves, only: [:index, :show] # 他ユーザー閲覧ページ用のルートを定義
  root 'home#index'

  get 'profiles/:id', to: 'profiles#show', as: 'profile'#新しいプロフィール表示ページ用

  resources :posts

  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end
end
