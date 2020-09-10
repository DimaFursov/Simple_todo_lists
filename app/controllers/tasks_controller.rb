class TasksController < ApplicationController
before_action :find_project,   only: [ :create, :update, :destroy]
before_action :find_task,      only: [ :update, :destroy]
 
  def index
    @tasks = Task.order(:position)
  end
  
  def sort
    params[:task].each_with_index do |id, index| 
    Task.where(id: id).update_all(position: index + 1)
    end    
    head :ok
  end  

  def create        
    @task = @project.tasks.build(task_params)
    if @task.save
      render partial: @task
    else      
      render json: @task.errors.messages, status: :unprocessable_entity
    end
  end
  
  def destroy
    @task.destroy
    render plain: "delete"
  end

  def update  
    #binding.pry
    if @task.update(task_params)
      render json: @task 
    else
      render json: @task.errors.messages, status: :unprocessable_entity
    end  
  end

  private

  def task_params
    params.require(:task).permit(:name, :status, :deadline)
  end

  def find_project
    @project = current_user.projects.find(params[:project_id])
  end

  def find_task
    @task = @project.tasks.find(params[:id])
  end  
end