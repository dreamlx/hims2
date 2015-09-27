Rails.application.routes.draw do
  resources :funds, except: [:show]
  resources :products do
    resources :rois, only: [:create, :update, :destroy]
  end
  resources :rois, only: :update
  resources :individuals
  resources :institutions
  resources :users
  resources :orders
  namespace :api do
    resources :users, only: [:create, :update, :show], defaults: {format: :json} do
      get :send_code, on: :collection, defaults: {format: :json}
      get :all_investors, on: :collection, defaults: {format: :json}
    end
    resources :funds, only: [:index], defaults: {format: :json} do
      resources :products, only: [:index], defaults: {format: :json}  
    end
    resources :products, only: [:show], defaults: {format: :json} do
      get :send_mail, on: :member, defaults: {format: :json}
    end
    resources :individuals, only: [:create, :index, :show, :update] ,defaults: {format: :json}
    resources :institutions, only: [:create, :index, :show, :update] ,defaults: {format: :json}
    resources :orders, only: [:create, :index] ,defaults: {format: :json}
  end
end
