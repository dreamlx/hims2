Rails.application.routes.draw do
  root 'welcome#index'
  resources :funds, except: [:show]
  resources :products do
    resources :rois, only: [:create, :destroy]
    resources :attaches, only: [:create, :destroy]
    resources :info_fields, only: [:create, :destroy]
  end
  resources :rois, only: :update
  resources :attaches, only: :update
  resources :info_fields, only: :update
  resources :individuals
  resources :institutions
  resources :users
  resources :orders do
    resources :infos, only: [:destroy] do
      get :confirm, on: :member
      get :deny, on: :member
    end
    resources :money_receipts, only: [:create, :destroy] do
      get :confirm, on: :member
      get :deny, on: :member
    end
    get :update_infos, on: :member
  end
  resources :money_receipts, only: :update
  resources :admins
  get     'login'   => 'sessions#new'
  post    'login'   => 'sessions#create'
  delete  'logout'  => 'sessions#destroy'
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
      get :my, on: :collection, defaults: {format: :json}
      get :ordered, on: :member, defaults: {format: :json}
    end
    resources :individuals, only: [:create, :index, :show, :update] ,defaults: {format: :json}
    resources :institutions, only: [:create, :index, :show, :update] ,defaults: {format: :json}
    resources :orders, only: [:create, :index, :show, :destroy, :update] ,defaults: {format: :json} do
      resources :money_receipts, only: [:create], defaults: {format: :json}
      patch :update_infos, on: :member, defaults: {format: :json}
      get :by_state, on: :collection, defaults: {format: :json}
      get :by_product, on: :collection, defaults: {format: :json}
    end
  end
end
