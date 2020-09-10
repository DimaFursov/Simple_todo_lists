class Task < ActiveRecord::Base
  belongs_to :project
  #acts_as_list scope: :todo_list #!
  default_scope -> { order(:position) }
  #scope -> { order(created_at: :desc) }
  #scope -> { order(:position) }
  
  validates :project_id, presence: true  
  validates :name, presence: true, length: { maximum: 255 }  
  validates :deadline, length: { maximum: 27 }#, presence: true
  
  #def print_all
  #  puts "print_all"
  #end

  #def self.find_by_id(id)
  #  Task.find(id)             #Task.find(id) self.find(id) тут будет эквивалентно так как у метода идёт 'def self.'
  #end

  def deadline_status
    if self.deadline < Time.now
      'Expired'
    else
      nil
    end
  end 
end
