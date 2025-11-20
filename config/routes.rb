Rails.application.routes.draw do
  devise_for :users

  # Health check route
  get "up" => "rails/health#show", as: :rails_health_check

  # Root path
  root "chats#index"

  # Chat routes
  resources :chats, only: [:index, :show, :new, :create] do
    resources :messages, only: [:create]
    post 'direct', on: :collection, to: 'chats#create_direct', as: :create_direct
  end

  # Messages routes is now nested under chats

  # Profile routes
  resources :profiles, only: [:index, :edit, :update, :show]
end
