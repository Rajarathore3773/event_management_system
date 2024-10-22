class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


  def admin?
    role == 'admin'
  end

  def project_manager?
    role == 'project_manager'
  end

  def regular_user?
    role == 'regular_user'
  end
end
