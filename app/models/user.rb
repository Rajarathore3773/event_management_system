class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         has_many :project_users, dependent: :destroy
         has_many :projects
         has_many :assigned_projects, through: :project_users, source: :project

         
  before_create :set_default_role

  def set_default_role
    self.role ||= 'regular_user' # Set default role to 'regular_user' if not chosen
  end
 

  def project_manager?
    role == 'project_manager'
  end

  def regular_user?
    role == 'regular_user'
  end




end
