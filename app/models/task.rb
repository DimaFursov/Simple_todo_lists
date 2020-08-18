class Task < ActiveRecord::Base
  belongs_to :project 
  default_scope -> { order(created_at: :desc) }
  validates :project_id, presence: true  
  validates :name, presence: true, length: { maximum: 255 }  
end
