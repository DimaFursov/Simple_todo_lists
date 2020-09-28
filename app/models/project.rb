class Project < ActiveRecord::Base
  belongs_to :user
  has_many :tasks, dependent: :destroy
  #default_scope -> { order(created_at: :desc) }  
  validates :user_id, presence: true  
  validates :name, presence: true, length: { maximum: 80 }
end