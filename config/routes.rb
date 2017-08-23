Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  get 'profile', to: 'users#show', as: 'profile'
 devise_for :users,
    controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :recipes do
    resources :doses, only: [:new, :create, :edit, :update, :destroy]
  end

  resources :ingredients

  resources :users, only: [:show] do
    resources :past_recommendations, only: [:create, :destroy]
  end
end



