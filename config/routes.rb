Rails.application.routes.draw do
  apipie

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api, defaults: {format: :json} do
  	namespace :v1 do
  		resource :user_session, only: [:create, :destroy]
      resource :user_registration, only: [:create]
      resource :users, only: [:update]
      resources :categories, only: [:index]
      resources :providers, only: [:index] do
        resources :products, only: [:index]
      end
  	end
  end
end
