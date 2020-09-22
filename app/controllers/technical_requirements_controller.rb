class TechnicalRequirementsController < ApplicationController

  #1. get all statuses, not repeating, alphabetically ordered
  def all_status_asc
    #render json: Project.select(:name, :status).order(name: :asc).unscoped
    render json: Task.select(:status).distinct.order(status: :asc)
    #Task.select(:status).distinct.order(status: :asc)

  end

  #2. get the count of all tasks in each project, order by tasks count descending
  def all_tasks_count_in_project_desc

    render json: Project.find_by_sql("SELECT p.name as project_name, count(t.id) as count_tasks 
      FROM projects p LEFT JOIN tasks t ON  t.project_id = p.id  GROUP BY project_name ORDER BY count_tasks DESC")
  end

  #3. get the count of all tasks in each project, order by projects names
  def all_count_tasks_project_order_projects_name
    render json: Project.find_by_sql("SELECT p.name as project_name, count(t.id) as count_tasks 
      FROM projects p LEFT JOIN tasks t ON  t.project_id = p.id  GROUP BY project_name ORDER BY project_name")
  end  

  #4. get the tasks for all projects having the name beginning with "N" letter
  def tasks_projects_name_beginning_n
    render json: Project.find_by_sql("SELECT t.name as task_name, p.name as project_name 
      FROM tasks t, projects p 
      WHERE p.name LIKE 'N%' AND t.project_id = p.id")
    # 'N%'
  end

  #5. get the list of all projects containing the 'a' letter in the middle of
  #the name, and show the tasks count near each project. Mentionthat there can exist projects without tasks and tasks with
  # project_id = NULL
  def list_projects_cont_a_middle
    render json: Project.find_by_sql("SELECT p.name as project_name, count(t.id) as count_tasks 
      FROM projects p LEFT JOIN tasks t on t.project_id = p.id 
      WHERE p.name LIKE '%a%' AND p.name NOT LIKE 'a%' AND p.name NOT LIKE '%a' GROUP BY project_name")
  end

  #6. get the list of tasks with duplicate names. Order alphabetically
  def tasks_duplicate_name_asc
    render json: Project.find_by_sql("SELECT name FROM tasks GROUP BY name HAVING count(*)>1 ORDER BY name")
  end  

  #7. get list of tasks having several exact matches of both name and
  #status, from the project 'Garage'. Order by matches count
  def tasks_exact_matches_both_name_status
    render json: Project.find_by_sql("SELECT t.name, COUNT(*) as task_count, t.status 
      FROM tasks t, projects p WHERE p.name='Garage' AND t.project_id = p.id GROUP BY t.name, t.status HAVING count(*)>1 ORDER BY task_count")
  end  
  
  #8. - get the list of project names having more than 10 tasks in status'completed'. Order by project_id
  def list_project_more_10_tasks_true
    #["name = ? AND status = true", "First Subject"]
    #Project.select(:project_id).where("status = ?", "true").order(:project_id)
    #Project.where(:id =>1).first

    render json: Project.find_by_sql("SELECT p.name 
      FROM projects p WHERE EXISTS (SELECT `project_id` FROM tasks t 
      WHERE p.id=t.project_id GROUP BY `project_id` AND t.status='true' HAVING count(*)>10) ORDER BY p.id ASC")    

  end  
end