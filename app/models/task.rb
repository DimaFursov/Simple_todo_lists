class Task < ActiveRecord::Base
  belongs_to :project
  #belongs_to :todo_list
  #acts_as_list scope: :todo_list  
  default_scope -> { order(:position) }
  validates :project_id, presence: true  
  validates :name, presence: true, length: { maximum: 255 }  
end
