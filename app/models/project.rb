class Project < ApplicationRecord
  belongs_to :user


  enum status: { not_started: 0, in_progress: 1, completed: 2 }

  validates :status, inclusion: { in: %w[not_started in_progress completed] }


  validates :title, :description, :start_date, :end_date, presence: true
end
