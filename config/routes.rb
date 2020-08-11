Rails.application.routes.draw do
  get 'sessions/new'
  root 'static_pages#home'
  get  'static_pages/home'
  get  'signup'  => 'users#new'
  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'
  post  'projects' => 'projects#create'
  patch  'projects' => 'projects#update'

  resources :users   
  resources :projects,            only: [:index, :create, :update, :show, :destroy]

end