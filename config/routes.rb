ArriveServer::Application.routes.draw do
  devise_for :users

  namespace :api do
    resource :session, only: :create

    resources :schools, only: :index do
      resources :courses, only: :index do
        resource :check_in, only: :create
      end
    end
  end

  resources :schools, only: [:index, :create, :all] do
    resources :courses, only: [:index, :create, :all]
    resources :reports, only: [:index]
    resources :users, only: [:index, :create] do
      collection do
        post :bulk_add
      end
    end
  end

  root to: 'home#index'
end
