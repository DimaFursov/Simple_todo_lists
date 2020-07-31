class User < ActiveRecord::Base
  attr_accessor :name, :email  
  validates :name, presence: true, length: { maximum: 50 }
  before_save   :downcase_email
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }    
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
  has_secure_password
  def authenticated?(attribute, token)
      digest = send("#{attribute}_digest")
      return false if digest.nil?
      BCrypt::Password.new(digest).is_password?(token)
      #BCrypt::Password.new(remember_digest).is_password?(remember_token)      
  end
    # Забывает пользователя
  def forget
    update_attribute(:remember_digest, nil)
  end
  private
    def downcase_email
      self.email = email.downcase
    end
  end    
