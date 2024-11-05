class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         has_many :project_users
         has_many :projects
         has_many :assigned_projects, through: :project_users, source: :project


  def project_manager?
    role == 'project_manager'
  end

  def regular_user?
    role == 'regular_user'
  end
end
