Rails.application.routes.draw do
  apipie

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api, defaults: {format: :json} do
  	namespace :v1 do
  		resource :user_session, only: [:create, :destroy] do
        resource :google, only: [:create], controller: "google_user_sessions"
      resource :users, only: [:update]
      end
      resource :user_registration, only: [:update]
      resource :profile, only: [:update]
      resources :users, only: [:show]
      resources :categories, only: [:index]
      resources :providers, only: [:index] do
        resources :products, only: [:show, :index] do
          resources :questions, only: [:create]
        end
      end

      namespace :commerce do
        resources :providers, only: [] do
          resources :orders, only: [:create]
        end
      end
  	end
  end
end
