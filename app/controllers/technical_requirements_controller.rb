class TechnicalRequirementsController < ApplicationController

  #1. get all statuses, not repeating, alphabetically ordered
  def all_status_asc
    #render json: Task.select(:name, :status).order(name: :asc).unscoped
    #render json: Task.select(:name, :status).order(name: :asc)
    render json: Task.select(:name, :status).order(status: :desc)
    #SELECT DISTINCT status FROM tasks ORDER BY status
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
    #render json: Project.find_by_sql("SELECT t.name as task_name, p.name as project_name FROM tasks t, projects p WHERE p.name LIKE "N%" AND t.project_id = p.id")
  end

  #5. get the list of all projects containing the 'a' letter in the middle of
  #the name, and show the tasks count near each project. Mentionthat there can exist projects without tasks and tasks with
  # project_id = NULL


  #6. get the list of tasks with duplicate names. Order alphabetically
  def tasks_duplicate_name_asc
    render json: Project.find_by_sql("SELECT name FROM tasks GROUP BY name HAVING count(*)>1 ORDER BY name")
  end  

  #7. get list of tasks having several exact matches of both name and
  #status, from the project 'Garage'. Order by matches count


  #8. - get the list of project names having more than 10 tasks in status'completed'. Order by project_id

end