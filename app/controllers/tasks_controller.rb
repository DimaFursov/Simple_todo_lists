class TasksController < ApplicationController
before_action :correct_project,   only: [ :edit, :update]#destroy

  def index
    @tasks = Task.all
  end

  def show
    @project = Project.find(params[:id])
    @task = Task.find(params[:id])
    
  end

  def create
    #binding.pry
    #debugger
    project = current_user.projects.find(params[:project_id])
    @task = project.tasks.build(task_params)
    if @task.save
      #render json: 'shared/taskslist', project_id: @task.project_id
      #render 'shared/taskslist', project: project

      render partial: 'shared/taskslist', project: project #undefined local variable or method `project'
    else
      render plain: "ERROR create"
    end
  end
  
  def destroy
    #@task.destroy
    #@project = current_user.projects.find(params[:project_id])
    #task[:task_id] = task.id
    #task.delete(:task_id)
    binding.pry
    @task.destroy        
    render plain: "delete"
  end

  def update 
    if @task.update(task_params)#update_attributes  
      render json: @task 
    else
      render json: @task.errors, status: :unprocessable_entity
    end  
  end

  private

  def task_params
    #binding.pry #ошибки в котроллере 
    params.require(:task).permit(:name) # status: true, priority: 1, deadline: nil разрешение на редактирование
                   #json ключ текст 
  end
  def correct_project
    @task = correct_project.tasks.find_by(id: params[:id])
    redirect_to root_url if @task.nil?
  end
end
=begin
    #task.all.name.reorder('status')
    #task = Task.where(project_id: '1').count

    render json: 'shared/taskslist', project_id: task.project_id                  
=end

#render json: 'tasks/task'     # только одну таску
      #flash[:success] = "task created!"
      #respond_to do |format|
      #format.html { redirect_to root_url }
      #@task = Task.new
#Task.create    
    # берем из объекта хеша :project_id
                                                # хеше ключ :project_id :task ищет ассоциативный масив json ключ текст 
    #undefined local variable or method `project'                                                
    #task = project.tasks.create(task_params)
    #@project = Project.find(params[:id])    
    #@task = Task.build(task_params)
    #@task = Task.create(task_params)
    #/*{"task"=>{"name"=>"dsadsadsa"}, "controller"=>"tasks", "action"=>"create", "project_id"=>"3"}*/
    #binding.pry
    #@project = current_user.projects.find(params[:id])