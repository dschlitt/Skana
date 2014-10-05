Rails.application.routes.draw do

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  authenticated :user do
    root to: 'users#show', as: :authenticated_root
  end

  resources :users, only: [:show, :update, :edit, :destroy]

  resources :pools do
    resources :pool_profiles
    get :match
  end

  resources :pods, only: [:index, :show] do
    delete :leave
  end

  resources :swipes, only: [:create]

end
