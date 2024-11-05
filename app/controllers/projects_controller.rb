class ProjectsController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_project_manager, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_project, only: [:show, :edit, :update, :destroy]

  def index 
    @projects = current_user.projects
  end

  def show
  end

  def new 
    @project = current_user.projects.build
    if @project.nil?
      redirect_to root_path, notice: "Project could not be created."
    end
  end

  def create
    @project = current_user.projects.build(project_params)

    if @project.save
      redirect_to projects_path, notice: "Project has been created successfully."
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @project.update(project_params)
      redirect_to @project, notice: 'Project was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    if @project.destroy
      redirect_to projects_path, notice: 'Project was successfully deleted.'
    else
      redirect_to projects_path, alert: 'Failed to delete the project.'
    end
  end
 
  private 
  
  def set_project
    @project = current_user.projects.find_by(id: params[:id])
    redirect_to projects_path, alert: "Project not found or you don't have access." if @project.nil?
  end

  def project_params
    params.require(:project).permit(:title, :description, :start_date, :end_date, :status)
  end

  def authorize_project_manager
    redirect_to(root_path, alert: "You are not authorized to perform this action.") unless current_user.role == "project_manager"
  end

end
