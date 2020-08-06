class ProjectsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy
  #def new
   # @projects = Project.new
    #render :partial => 'projects/project'
  #end

  #def index
   # @projects = Project.all
  #end

  def create
    @project = current_user.projects.build(project_params)
    if @project.save
      flash[:success] = "project created!"
      redirect_to root_url
    else
      @feed_itemsprojects = []
      render 'static_pages/home'
    end
  end
  def update
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to @project, notice: 'Project was successfully updated.' }
        format.json { render :show, status: :ok, location: @project }
      else
        format.html { render :edit }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
  end  
  def destroy
    @project.destroy
    flash[:success] = "Project deleted"
    redirect_to request.referrer || root_url
  end

  #def project_params
   #   params.require(:projects).permit(:name)
  #end

  private

    def project_params
     params.require(:projects).permit(:name)
    end

    def set_project
      @project = Project.find(params[:id])
    end
    def correct_user
      @project = current_user.projects.find_by(id: params[:id])
      redirect_to root_url if @project.nil?
    end        
  end
end  