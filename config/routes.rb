Rails.application.routes.draw do
  devise_for :admins, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  apipie

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api, defaults: {format: :json} do
  	namespace :v1 do
  		resource :user_session, only: [] do
        resource :google, only: [:create], controller: "google_user_sessions"
      end
      resource :user_registration, only: [:create, :update]
      resource :profile, only: [:update]
      resources :users, only: [:show]
      resources :categories, only: [:index]

      namespace :provider do
        resources :discounts, only: [:index]
        resources :orders, only: [:index, :show] do
          member do
            post :accept
            post :reject
          end
        end
        resources :questions, only: [:index, :update]
      end

      namespace :commerce do
        resources :orders, only: [:index, :show]
        resources :questions, only: [:index]
        resources :discounts, only: [:index]

        resources :providers, only: [:index] do
          resources :products, only: [:show, :index] do
            resources :questions, only: [:create]
          end
          resources :orders, only: [:create]
        end
      end
  	end
  end
end
