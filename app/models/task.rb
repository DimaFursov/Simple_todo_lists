class Task < ActiveRecord::Base
  belongs_to :project
  default_scope -> { order(:position) }
  validates :project_id, presence: true  
  validates :name, presence: true, length: { maximum: 255 }  
  validates :deadline, length: { maximum: 27 }
  
  def deadline_status
    if self.deadline < Time.now
      'Expired'
    else
      nil
    end
  end 
end
