Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      get 'suggest', to: 'actions#suggest'
      get 'search', to: 'actions#search'
      get 'ban', to: 'actions#ban_ingredient'
      get 'unban', to: 'actions#unban_ingredient'
      get 'banned', to: 'actions#banned_ingredients'
      get 'select', to: 'actions#select_recipe'
      get 'history', to: 'actions#history'
    end
  end

  devise_for :users,
    controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  root to: 'pages#home'

  resources :recipes, only: [:show]  do
    resources :doses, only: [:new, :create, :edit, :update, :destroy]
    member do
      put "like", to: "recipes#upvote"
      put "dislike", to: "recipes#downvote"
    end
  end

  resources :ingredients, only: [:index, :show] do
    member do
      put "like", to: "ingredients#upvote"
      put "dislike", to: "ingredients#downvote"
    end
  end

  resources :users, only: [:show] do
    resources :past_recommendations, only: [:create, :destroy]
  end
end






