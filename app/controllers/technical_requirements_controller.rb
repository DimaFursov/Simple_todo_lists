class TechnicalRequirementsController < ApplicationController

  def all_status_asc
    render json: Task.select(:name, :status).order(name: :asc).unscoped
    
    
    #@tasks = Task.select(:name, :status).order(name: :asc)
    #@tasks = Task.all
    #render Task.select(:name, :status).order(name: :asc)
    # @task = Task.select(:name, :status)
    #render Task.order(name: :asc).all
  end

    #get the count of all tasks in each project, order by tasks count descending
  def all_tasks_count_in_project_desc
    render text:"Task.count #{Task.count}"
    
=begin    
    all_tasks_count_in_project_desc = "SELECT Projects.ID, Projects.Name, COUNT(Tasks.ProjectID) 
    FROM Projects 
      LEFT JOIN Tasks 
      ON Tasks.ProjectID = Projects.ID
      GROUP BY Projects.ID"
      #AND Assignee=1
=end  
  end

end  