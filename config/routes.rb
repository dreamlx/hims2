Rails.application.routes.draw do
  resources :funds, except: [:show]
  resources :products do
    resources :rois, only: [:create, :update, :destroy]
  end
  resources :rois, only: :update
  namespace :api do
    resources :users, only: [:create, :update], defaults: {format: :json} do
      get :send_code, on: :collection, defaults: {format: :json}
    end
    resources :funds, only: [:index], defaults: {format: :json} do
      resources :products, only: [:index], defaults: {format: :json}  
    end
    resources :products, only: [:show], defaults: {format: :json} do
      get :send_mail, on: :member, defaults: {format: :json}
    end
  end
end
