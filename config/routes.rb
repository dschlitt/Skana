Rails.application.routes.draw do
  resources :users, only: [:show, :update, :edit, :destroy]
end
