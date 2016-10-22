Rails.application.routes.draw do
  root 'welcome#index'
  resources :funds, except: [:show]
  resources :products do
    resources :rois, only: [:create, :destroy]
    resources :attaches, only: [:create, :destroy]
  end
  resources :rois, only: :update
  resources :attaches, only: :update
  resources :individuals do
    get :confirm, on: :member
    get :deny, on: :member
  end
  resources :institutions do
    get :confirm, on: :member
    get :deny, on: :member
  end
  resources :users do
    get :confirm, on: :member
    get :deny, on: :member
  end
  resources :orders do
    post :muti_status_update, on: :collection
    resources :money_receipts, only: [:create, :destroy] do
      get :confirm, on: :member
      get :deny, on: :member
    end
    resources :pictures, only: [:create, :destroy] do
      get :confirm, on: :member
      get :deny, on: :member
    end
  end
  resources :money_receipts, only: [:update, :index]
  resources :pictures, only: [:update, :index]
  resources :admins do
    get :edit_role, on: :member
  end
  get     'login'   => 'sessions#new'
  post    'login'   => 'sessions#create'
  delete  'logout'  => 'sessions#destroy'
  namespace :api do
    resources :config, defaults: {format: :json} do
      get :fullname, on: :collection
      get :shortname, on: :collection
      get :phone, on: :collection
      get :email, on: :collection
      get :address, on: :collection
      get :detail, on: :collection
    end
    resources :users, only: [:create, :update, :show], defaults: {format: :json} do
      get :send_code, on: :collection, defaults: {format: :json}
      get :all_investors, on: :collection, defaults: {format: :json}
      get :receive_code, on: :collection
      post :risk_evaluation, on: :collection, defaults: {format: :json}
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
      resources :money_receipts, only: [:create, :destroy], defaults: {format: :json}
      resources :pictures, only: [:create, :destroy], defaults: {format: :json}
      get :by_state, on: :collection, defaults: {format: :json}
      get :by_product, on: :collection, defaults: {format: :json}
      get :by_number, on: :collection, defaults: {format: :json}
    end
  end
end
