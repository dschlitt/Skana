Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  resources :users, only: [:show, :update, :edit, :destroy]

  resources :pools do
    resources :pool_profiles
  end

  resources :pods, only: [:index, :show] do
    delete :leave
  end

end
