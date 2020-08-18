class TasksController < ApplicationController
before_action :correct_project,   only: [ :destroy, :edit, :update]
    #вытянуть из базы таски чей :project_id соответствует id проекта 
  # SELECT * FROM tasks WHERE project_id = <project id>
  
  def index
    @tasks = Task.all
  end

  def show
    @project = Project.find(params[:id])
    @task = Task.find(params[:id])
    $NOT_CONST = "NOT_CONST"    
  end

  def create #Task.create    
    @task = Task.build(task_params)
    if @task.save
      flash[:success] = "task created!"
      redirect_to request.referrer || root_url
      @task = Task.new      
    else
      render 'static_pages/home'
    end
  end
  
  def destroy
    @task.destroy
    flash[:success] = "task deleted"    
    redirect_to request.referrer || root_url
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
