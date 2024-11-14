Rails.application.routes.draw do
  # ログイン済みユーザー用のルート
  authenticated :user do
    root to: 'bookshelves#index', as: :authenticated_root
  end

  # 未ログインユーザー用のルート
  unauthenticated do
    root to: 'home#index', as: :unauthenticated_root
  end

  devise_for :users, controllers: { registrations: 'users/registrations' }

  resources :users, only: [:show, :edit, :update] do
    member do
      post 'follow', to: 'follows#create'
      delete 'unfollow', to: 'follows#destroy'

      # フォロワーとフォロー中のルートを追加
      get 'followers', to: 'users#followers'
      get 'following', to: 'users#following'
    end
  end

  get 'profiles/:id', to: 'profiles#show', as: 'profile'

  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end

  resources :bookshelves, only: [:index, :show] do
    member do
      get :post_detail
    end
  end

  resources :plaza_posts do
    resources :comments, only: [:create, :destroy, :edit, :update] do
      member do
        post :like
        delete :unlike
      end
    end
  end

  resources :posts do
    collection do
      post :toggle_bookshelf_visibility
    end
    member do
      post 'like', to: 'likes#like'
      delete 'unlike', to: 'likes#unlike'
    end
  end
end
