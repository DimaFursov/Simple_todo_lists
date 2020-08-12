class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy]
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy
  
  def index # первый 
    @projects = Project.all
  end
  def new
    @project = Project.new    
  end
  def show # должны работать как апи все запросы возвращать json с объектом или меседжом
    @project = Project.find(params[:id])
    #render json: @project
  end


  def create
    @simple_number = 186 #работает
    @user= current_user
    @project = current_user.projects.build(project_params) # не видет id
    @project_id_js = @project.id.to_s
    if @project.save      
      @projects = current_user.projects
      @project_count = current_user.projects.count
      flash[:success] = "---project created!---"
      respond_to do |format|
      format.html { redirect_to root_url }
      format.js
      @project = Project.new
      end
    else
      @feed_itemsprojects = []
      render 'static_pages/home'
    end
  end
  def update
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to root_url, notice: 'Project was successfully updated.' }
        format.json { render :show, status: :ok, location: @project }
      else
        format.html { render :edit }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end  
  end  
  def destroy
    @project_id_js = @project.id
    @project.destroy
    flash[:success] = "Project deleted"
    #redirect_to root_url
    #redirect_to request.referrer || root_url
    render plain: "delete"
  end


  private

  def project_params
    params.require(:project).permit(:name) #разрешение на редактирование
  end

  def set_project
    @project = Project.find(params[:id])
  end
  def correct_user
    @project = current_user.projects.find_by(id: params[:id])
    redirect_to root_url if @project.nil?
  end
end          
