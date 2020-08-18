class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @tasks = Task.all
      #@task = @project.tasks
      @project = current_user.projects.build
      @projects = current_user.projects
      @project_count = current_user.projects.count
      #@task = project.tasks.build #current_project session
      #@task_project = task.projects
    end  
  end
end
