class TasksController < ApplicationController
before_action :logged_in_user, only: [ :create, :update, :destroy]
before_action :find_project,   only: [ :create, :update, :destroy]
before_action :find_task,      only: [ :update, :destroy]
  
  def sort
    params[:task].each_with_index do |id, index| 
    Task.where(id: id).update_all(position: index + 1)
    end    
    head :ok
  end  
  
  def create
    @task = @project.tasks.new(task_params)
    if @task.save
      @tasks = Task.all
      @tasks.each do |t|
        if t.id != @task.id
          t.position = t.position + 1
          t.save
        end
      end
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
    #@task_position = @task.position
    #binding.pry
    #params.require(:task).permit(:name, :status, :deadline)
    if @task.update(task_params)
      render json: @task
    else
      render json: @task.errors.messages, status: :unprocessable_entity
    end
  end

  private

  def task_params
    
    params[:task][:position] = 1
    params.require(:task).permit(:name, :status, :deadline, :position)#, :priority :position
  end

  def find_project
    @project = current_user.projects.find(params[:project_id])
  end

  def find_task
    @task = @project.tasks.find(params[:id])
  end  
end