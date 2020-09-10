class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @projects = current_user.projects
      @project = current_user.projects.build #<Project:0x007f2a8efa1760 id: nil, name: nil, user_id: 1, created_at: nil, updated_at: nil>
      
      
      #@project_count = current_user.projects.count
      @date = Time.now
     

      
    end  
  end
end