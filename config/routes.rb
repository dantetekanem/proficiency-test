Rails.application.routes.draw do
  resources :students do
    get :search, on: :collection
  end
  resources :courses do
    get :search, on: :collection
  end
  resources :classrooms, only: [:index, :create, :update, :destroy]
  root to: 'home#index'
end
