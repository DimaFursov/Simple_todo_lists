class ProjectsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy

  def create
    @project = current_user.projects.build(project_params)
    if @project.save
      flash[:success] = "---project created!---"
      respond_to do |format|
      format.html { redirect_to root_url }
      format.js
      #format.flash {[:success] = "---project created!---"}
      end
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
  end  
  def destroy
    @project.destroy
    flash[:success] = "Project deleted"
    redirect_to request.referrer || root_url
  end


  private

  def project_params
    params.require(:project).permit(:name)
  end

  def set_project
    @project = Project.find(params[:id])
  end
  def correct_user
    @project = current_user.projects.find_by(id: params[:id])
    redirect_to root_url if @project.nil?
  end
end          
