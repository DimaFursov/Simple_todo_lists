class UsersController < ApplicationController
  before_action :logged_in_user, only: [ :edit, :update, :destroy]
  before_action :correct_user,   only: [ :show, :edit, :update]

  def index
    @projects = Project.all
  end

  def show
    @user = User.find(params[:id])
    @projects = @user.projects
    @project = Project.find(params[:id]) # @project должна предналежать Active Record::Relation
    @task = @project.tasks
    @tasks = @project.tasks
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "Welcome"
      redirect_to root_url
    else
      render 'new'
    end
  end

private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def logged_in_user
    unless logged_in?
      flash[:danger] = "Please log in."
      redirect_to login_url
    end
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end
end