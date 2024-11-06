Rails.application.routes.draw do
  root 'home#index'

  # Devise routes for user authentication
  devise_for :users, controllers: { registrations: 'users/registrations' }

  # User profile routes
  resources :users, only: [:show, :edit, :update]
  get 'profiles/:id', to: 'profiles#show', as: 'profile'

  # Guest sign-in route
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end

  # Bookshelves routes for viewing other users' bookshelves
  resources :bookshelves, only: [:index, :show]
  resources :plaza_posts, only: [:index, :show, :new, :create]

  # Posts routes with additional actions
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
