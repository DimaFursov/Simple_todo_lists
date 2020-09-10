class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @projects = current_user.projects
      @project = current_user.projects.new
      @date = Time.now
    end  
  end
end