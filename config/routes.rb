Rails.application.routes.draw do
  get 'messages/show'
  get 'relationships/index'
  get 'posts/index'
  get 'tags/index'
  get 'users/show'
  get 'contact', to: 'toppages#contact'
  devise_for :users, controllers: {
    sessions: "users/sessions",
    registrations: "users/registrations"
  }
  get 'toppages/index'
  root to: 'toppages#index'
  resources :users, only: [:show, :new, :create, :edit, :destroy, :update] do
    member do
      get :add_tag
      get :followings
      get :followers
    end
  end
  resources :posts, only: [:index, :show, :create, :destroy]
  resources :tags, only: [:index, :show, :create, :destroy]
  resources :relationships, only: [:create, :destroy]
  resources :messages, only: [:index, :show]
  
  mount ActionCable.server => '/cable'

  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
    get 'profile_edit', to: 'users/registrations#profile_edit', as: 'profile_edit'
    patch 'profile_update', to: 'users/registrations#profile_update', as: 'profile_update'
  end

end
