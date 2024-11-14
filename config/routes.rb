Rails.application.routes.draw do
  root 'home#index'

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

  resources :bookshelves, only: [:index,:show] do
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

  def after_sign_in_path_for(resource)
    dashboard_path
  end

  def after_sign_out_path_for(resource_or_scope)
    root_path
  end
end
