Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :recipes do
    resources :doses, only: [:new, :create, :edit, :update, :destroy]
  end

  resources :ingredients

end



