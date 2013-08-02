ArriveServer::Application.routes.draw do
  get "admin/index"
  post 'admin/add'

  devise_for :users
  devise_scope :user do
    namespace :api do
      resource :session, only: [:create]
    end
  end

  resources :courses, only: [:index, :create]
  resources :reports, only: :index do
    post :search, on: :collection
  end
  resources :users, only: [:index, :create]
  resources :schools, only: [:index, :create]

  root to: 'home#index'


end
