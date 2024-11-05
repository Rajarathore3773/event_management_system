class ProjectUsersController < ApplicationController
  before_action :authorize_project_manager, only: [:add_user, :assign_role, :remove_user,:update_user]

  def add_user
    #  debugger
    @project = Project.find(params[:id])
    @users = User.where.not(id: @project.users.pluck(:id))
    @users = @users.where.not(id: current_user.id)
  end

  def assign_role
        # debugger
      @project = Project.find(params[:id])
      @project_user = @project.project_users.new(project_user_params)
      if @project_user.save!
        redirect_to @project, notice: 'User was successfully added to the project with the role.'
      else
        render :add_user, alert: 'Failed to add user to the project.'
      end
    end

  def remove_user
    @project = Project.find(params[:id])
    project_user = @project.project_users.find_by(user_id: params[:user_id])
    
    if project_user&.destroy
      redirect_to @project, notice: 'User was successfully removed from the project.'
    else
      redirect_to @project, alert: 'Failed to remove user from the project.'
    end
  end

  def edit_user
    @project = Project.find(params[:id])
    @project_user = @project.project_users.find_by(user_id: params[:user_id])
  end
  
  def update_user
    @project = Project.find(params[:id])
    @project_user = @project.project_users.find_by(user_id: params[:user_id])
  
    if @project_user.update(project_user_params)
      redirect_to @project, notice: 'User role was successfully updated.'
    else
      redirect_to @project, alert: 'Failed to update user role.'
    end
  end

  private

  def project_user_params
    params.permit(:user_id, :role)
  end

  def authorize_project_manager
    redirect_to(root_path, alert: "You are not authorized to perform this action.") unless current_user.role == "project_manager"
  end
end
