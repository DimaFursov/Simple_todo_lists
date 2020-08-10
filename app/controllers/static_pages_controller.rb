class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @project = current_user.projects.build
      @projects = current_user.projects
      @project_count = current_user.projects.count
      
    end  
  end
end
