Rails.application.routes.draw do
  resources :funds
  namespace :api do
    resources :users, only: [:create, :update], defaults: {format: :json} do
      get :send_code, on: :collection, defaults: {format: :json}
    end
    resources :funds, only: [:index], defaults: {format: :json}
  end
end
