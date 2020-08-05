class Project < ActiveRecord::Base
  belongs_to :user # @user.projects.build
  default_scope -> { order(created_at: :desc) }  
  validates :user_id, presence: true  
  validates :name, presence: true, length: { maximum: 140 }  #presence: true  
end