ArriveServer::Application.routes.draw do
  devise_for :users

  namespace :api do
    resource :session, only: :create

    resources :schools, only: :index do
      resources :courses, only: :index do
        resource :check_in, only: :create
      end
    end

    match "*all" => "api#options", via: :options
  end

  resources :schools, only: [:index, :create] do
    resources :courses, only: [:index, :create]
    resources :reports, only: :index
    resources :users, only: [:index, :create] do
      collection do
        post :bulk_add
      end
    end
    resource :pin, only: [:new]
  end

  root 'home#index'
end
