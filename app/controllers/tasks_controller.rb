class TasksController < ApplicationController
before_action :logged_in_user, only: [ :index, :create, :update, :destroy]
before_action :find_project,   only: [ :create, :update, :destroy]
before_action :find_task,      only: [ :update, :destroy]


  def index
    @tasks = Task.all.unscoped#order(:position).all#published
  end  
  
  def sort
    params[:task].each_with_index do |id, index| 
    Task.where(id: id).update_all(position: index + 1)
    end    
    head :ok
  end  
  
  def create
    params[:task][:position] = 1
    params[:task][:status] = false # status: false
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
      #Task.order(position: :asc).all
    else      
      render json: @task.errors.messages, status: :unprocessable_entity
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
      render json: @task.errors.messages, status: :unprocessable_entity
    end
  end

  private

  def task_params
    params.require(:task).permit(:name, :status, :deadline, :position)
  end

  def find_project
    @project = current_user.projects.find(params[:project_id])
  end

  def find_task
    @task = @project.tasks.find(params[:id])
  end  
end