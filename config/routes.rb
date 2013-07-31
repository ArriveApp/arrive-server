ArriveServer::Application.routes.draw do
  get "admin/index"
  post 'admin/add'

  devise_for :users
  devise_scope :user do
    namespace :api do
      resource :session, only: [:create]
    end
  end

  resources :classes, only: [:index, :create]
  resources :reports, only: :index
  resources :users, only: :index

  root to: 'home#index'


end
