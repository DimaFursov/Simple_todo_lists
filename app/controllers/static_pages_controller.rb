class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @project = current_user.projects.build
      @feed_itemsprojects = current_user.feedprojects
    end  
  end
end
