Rails.application.routes.draw do
  resources :users, only: [:index, :create, :show, :destroy]
end
