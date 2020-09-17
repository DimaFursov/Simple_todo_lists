Rails.application.routes.draw do

  get 'all_tasks_count_in_project_desc' => 'technical_requirements#all_tasks_count_in_project_desc'
  get 'all_status_asc' => 'technical_requirements#all_status_asc'
  get 'all_count_tasks_project_order_projects_name' => 'technical_requirements#all_count_tasks_project_order_projects_name'
  get 'tasks_projects_name_beginning_n' => 'technical_requirements#tasks_projects_name_beginning_n'
  get 'tasks_duplicate_name_asc' => 'technical_requirements#tasks_duplicate_name_asc'

   
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