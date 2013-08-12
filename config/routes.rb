ArriveServer::Application.routes.draw do
  devise_for :users
  devise_scope :user do
    namespace :api do
      resource :session, only: [:create], :via => [:post]
    end
  end

  namespace :api do
    resources :schools, only: :index do
      resources :courses, only: :index do
        resource :check_in, only: :create
      end
    end
  end

  resources :reports, only: :index do
    post :search, on: :collection
  end

  resources :schools, only: [:index, :create, :all] do
    resources :courses, only: [:index, :create, :all]
    resources :users, only: [:index, :create] do
      collection do
        post :bulk_add
      end
    end
  end

  root to: 'home#index'
  namespace :api do
      match "session" => "api#options", :via => [:options]
  end
  
end
