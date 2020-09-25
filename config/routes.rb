Rails.application.routes.draw do

  get 'all_status_asc' => 'technical_requirements#all_status_asc'
  get 'all_tasks_count_in_project_desc' => 'technical_requirements#all_tasks_count_in_project_desc'
  get 'all_count_tasks_project_order_projects_name' => 'technical_requirements#all_count_tasks_project_order_projects_name'
  get 'tasks_projects_name_beginning_n' => 'technical_requirements#tasks_projects_name_beginning_n'
  get 'list_projects_cont_a_middle' => 'technical_requirements#list_projects_cont_a_middle'
  get 'tasks_duplicate_name_asc' => 'technical_requirements#tasks_duplicate_name_asc'
  get 'tasks_exact_matches_both_name_status_from_project_name_Garage' => 'technical_requirements#tasks_exact_matches_both_name_status_from_project_name_Garage'
  get 'list_project_more_10_tasks_true' => 'technical_requirements#list_project_more_10_tasks_true'
  
  get 'sessions/new'
  root 'static_pages#home'
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