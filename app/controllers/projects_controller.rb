class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :update, :destroy]
  before_action :logged_in_user, only: [:create, :edit, :update, :destroy]
  before_action :correct_user,   only: [:destroy, :edit, :update]
  
  def index
    @projects = Project.all
  end
  def new
    @project = Project.new    
  end
  def show 
    @project = Project.find(params[:id]) # @project должна предналежать Active Record::Relation
    @task = Task.find(params[:project_id])
    @tasks = @project.tasks        
  end

  def create
    @user= current_user
    @project = current_user.projects.build(project_params)
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

  def edit
    @projectID = Project.find(params[:id])
  end

  def update 
    if @project.update(project_params)#update_attributes  
      render json: @project 
    else
      render json: @project.errors, status: :unprocessable_entity
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
    #binding.pry #ошибки в котроллере
    params.require(:project).permit(:name) #разрешение на редактирование
                   #json ключ текст 
  end

  def set_project
    @project = Project.find(params[:id])
  end
  def correct_user
    @project = current_user.projects.find_by(id: params[:id])
    redirect_to root_url if @project.nil?
  end
end          
