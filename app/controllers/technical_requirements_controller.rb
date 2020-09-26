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
=begin    
    render json: Project.find_by_sql("
      SELECT p.name as project_name, count(t.id) as count_tasks 
      FROM projects p LEFT JOIN tasks t on t.project_id = p.id 
      WHERE p.name LIKE '%a%' AND p.name NOT LIKE 'a%' AND p.name NOT LIKE '%a' GROUP BY project_name")
=end   

  #6. get the list of tasks with duplicate names. Order alphabetically
  def tasks_duplicate_name_asc
    tasks = Task.unscoped.select(:name).distinct.order(name: :asc).map do |task|
      {
        distinct_task_name: task.name #project.tasks
      }
    end 
    render json: tasks
    #render json: Project.find_by_sql("SELECT name FROM tasks GROUP BY name HAVING count(*)>1 ORDER BY name")
  end  

  #7. get list of tasks having several exact matches of both name and status,
  #   from the project 'Garage'. Order by matches count
  def tasks_exact_matches_both_name_status_from_project_name_Garage    
    projects = Project.includes(:tasks).where('projects.name = ?', 'Garage').map do |project|  #.order(garage_tasks_distinct_count: :asc)
      garage_id = project.id
      garage_tasks_distinct = Task.where('tasks.project_id = ?', garage_id).select(:name, :status).distinct      
      # Order by matches count
      count = Task.where('tasks.project_id = ?', garage_id).select(:name, :status).distinct.count(:name, :status)
      count2 = Task.where('tasks.project_id = ?', garage_id).select(:name, :status).distinct.count(:name, :status)
      # .having('count(*)>1')#.group('count')
      {
        garage_tasks_distinct_count: count,
        project_name: project.name,
        garage_tasks_distinct: garage_tasks_distinct,
      }
    end
    #projects.sort_by! { |hsh| -hsh[:garage_tasks_distinct_count]}
    render json: projects
  end    

  #8. - get the list of project names having more than 10 tasks in status'completed'. Order by project_id
  def list_project_more_10_tasks_true
    
    #Project.select(:project_id).where("status = ?", "true").order(:project_id)
    #Project.where(:id =>1).first

    projects = Project.includes(:tasks).unscoped.map do |project|
      a = project.tasks.each do |task| 
        count = 0
          if task.status == true 
            count+=1
            if count > 10 then
              {
                b: b,
                task_count1: task.status,
                count: count
              }
            end
          end
        end
      {
        projects: project.name,
        count_tasks: a
      }
    end
    projects.sort_by! { |x| x[projects]}  
    render json: projects

=begin    
    render json: Project.find_by_sql("SELECT p.name 
      FROM projects p WHERE EXISTS (SELECT `project_id` FROM tasks t 
      WHERE p.id=t.project_id GROUP BY `project_id` AND t.status='true' HAVING count(*)>10) ORDER BY p.id ASC")    
=end      

  end  
end