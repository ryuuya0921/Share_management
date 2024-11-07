Rails.application.routes.draw do
  root 'home#index'

  devise_for :users, controllers: { registrations: 'users/registrations' }

  resources :users, only: [:show, :edit, :update]
  get 'profiles/:id', to: 'profiles#show', as: 'profile'

  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end

  resources :bookshelves, only: [:index, :show]

  resources :plaza_posts do
    resources :comments, only: [:create, :destroy, :edit, :update]
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
