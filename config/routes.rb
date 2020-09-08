Rails.application.routes.draw do

  get 'allstatusabc' => 'application#allstatusabc'
  get 'sessions/new'
  root 'static_pages#home'
  get  'static_pages/home'
  get  'signup'  => 'users#new'
  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'
    
  resources :users     
  resources :projects do
    resources :tasks
  end  
  resources :tasks do 
    collection do
      patch :sort
    end
  end  
end