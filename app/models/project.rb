class Project < ApplicationRecord
  # ApplicationRecord
  # ActiveRecord::Base
  # model is ready to have its association required by default

  # self.belongs_to_required_by_default = true

  # belongs_to will now trigger a validation error by default if the association is not present.
  # This can be turned off per-association with optional: true.
  
  belongs_to :user
  has_many :tasks, dependent: :destroy
  #default_scope -> { order(created_at: :desc) }  
  validates :user_id, presence: true  
  validates :name, presence: true, length: { maximum: 80 }
end