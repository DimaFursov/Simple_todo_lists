Rails.application.routes.draw do

  get 'defApplication' => 'application#defApplication'
  get 'defFromProjectsController' => 'projects#defFromProjectsController'
  get 'all_tasks_count_in_project_desc' => 'tasks#all_tasks_count_in_project_desc'
  get 'all_status_asc' => 'technical_requirements#all_status_asc'
  
   
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