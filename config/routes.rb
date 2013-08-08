ArriveServer::Application.routes.draw do
  get "admin/index"
  post 'admin/add'

  devise_for :users
  devise_scope :user do
    namespace :api do
      resource :session, only: [:create]
    end
  end

  resources :reports, only: :index do
    post :search, on: :collection
  end
  resources :schools, only: [:index, :create] do
    resources :courses, only: [:index, :create]
    resources :users, only: [:index, :create]
  end

  root to: 'home#index'

  get 'schools/all', to: 'schools#get'

end
