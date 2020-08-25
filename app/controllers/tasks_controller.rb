class TasksController < ApplicationController
before_action :find_project,   only: [ :create, :update, :destroy]
before_action :find_task,      only: [ :update, :destroy]

  def index
    @tasks = Task.order(:position)
  end
  #/*task[]=51&task[]=50&task[]=58*/
  def sort
    #binding.pry #PATCH "/tasks/sort" #/* {"task"=>["58", "50", "51"], "controller"=>"tasks", "action"=>"sort"} */      
    params[:task].each_with_index do |id, index| #id from each one item in the index
      Task.where(id: id).update_all(position: index + 1)
    end
    #@tasks = Task.order(:position)
    head :ok
  end  

  def create        
    @task = @project.tasks.build(task_params)
    if @task.save
      render partial: @task #@task = Task.new      
    else
      render plain: "ERROR create"
    end
  end
  
  def destroy
    @task.destroy
    render plain: "delete"
  end

  def update
    if @task.update(task_params)
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

  def find_project
    @project = current_user.projects.find(params[:project_id])
  end

  def find_task
    @task = @project.tasks.find(params[:id])
  end  
end