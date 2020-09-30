class TechnicalRequirementsController < ApplicationController

  #1. get all statuses, not repeating, alphabetically ordered
  def all_status_asc
    render json: Task.unscoped.select(:status).distinct.order(status: :asc)
  end

  #2. get the count of all tasks in each project, order by tasks count descending
  def all_tasks_count_in_project_desc
    projects = Project.includes(:tasks).map do |project|
      {
        tasks_count: project.tasks.count,
        project_name: project.name
      }
    end
    projects.sort_by! { |hsh| -hsh[:tasks_count]}
    render json: projects
  end

  #3. get the count of all tasks in each project, order by projects names
  def all_count_tasks_project_order_projects_name
    projects = Project.includes(:tasks).map do |project|
      {
        tasks_count: project.tasks.count,
        project_name: project.name
      } 
    end
    projects.sort_by! { |x| x[:project_name]}  
    render json: projects
  end  

  #4. get the tasks for all projects having the name beginning with "N" letter
  def tasks_projects_name_beginning_n
    projects = Project.includes(:tasks).unscoped.where("projects.name LIKE 'N%'").map do |project|
      {
        project_name: project.name,
        tasks: project.tasks
      }
    end
    render json: projects
  end      

  #5. get the list of all projects containing the 'a' letter in the middle of
  #the name, and show the tasks count near each project. Mentionthat there can exist projects without tasks and tasks with
  # project_id = NULL
  def list_projects_cont_a_middle
    projects = Project.includes(:tasks).unscoped.where("
      projects.name LIKE '%a%' AND projects.name NOT LIKE 'a%' AND projects.name NOT LIKE '%a'").map do |project|
      {
        projects: project.name,
        count_tasks: project.tasks.count
      }
    end
    projects.sort_by! { |x| x[:project_name]}  
    render json: projects
  end

  #6. get the list of tasks with duplicate names. Order alphabetically
  def tasks_duplicate_name_asc
    tasks = Task.unscoped.select(:name).distinct.order(name: :asc).map do |task|
      {
        distinct_task_name: task.name
      }
    end 
    render json: tasks
  end 

  #7. get list of tasks having several exact matches of both name and status,
  #   from the project 'Garage'. Order by matches count
  def tasks_exact_matches_both_name_status_from_project_name_Garage  
  #projects = Project.includes(:tasks).unscoped.where('projects.name = ?', 'Garage').map do |project| project.tasks.unscope(:order).group(:name, :status).order('count_name desc').having('count(name) > 1').count(:name) end
    projects = Project.includes(:tasks).unscoped.where('projects.name = ?', 'Garage').map do |project|
      count_group_name_status = project.tasks.unscope(:order).group(:name, :status).order('count(name) desc').having('count(name) > 1').count(:name)
      # pg count(name)
      {
        project_name: project.name,
        garage_tasks_count_desc: count_group_name_status
      }
    end
    render json: projects
  end    

  #8. - get the list of project names having more than 10 tasks in status'completed'. Order by project_id
  def list_project_more_10_tasks_true
=begin    
    render json: Project.find_by_sql("
      SELECT p.name 
      FROM projects p WHERE EXISTS (SELECT `project_id` FROM tasks t 
      WHERE p.id=t.project_id GROUP BY `project_id` AND t.status='true' HAVING count(*)>10) ORDER BY p.id ASC")  
=end
    projects = Project.includes(:tasks).unscoped.map do |project|
      
      a = project.tasks.unscope(:order).group(:status).order(:project_id).having('count_status > 10').count(:status)
      
      {
        project_name: project.name,
        a: a
      }
      #end
    end
    #projects = projects.compact
    #projects.sort_by! { |hsh| -hsh[:project_id]}
    render json: projects

  end  
end