class User < ApplicationRecord
  before_save :downcase_email

  VAILID_PHONENUMBER_REGEX = /\A\d{10}\z/
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :first_name,   presence: true, length: {maximum: 50} 
  validates :last_name,    presence: true, length: {maximum: 50}
  validates :phone_number, presence: true, length: {maximum: 10},
                           format: {with: VAILID_PHONENUMBER_REGEX},
                           uniqueness: true
  validates :email,        presence: true, length: {maximum: 255}, 
                           format: {with: VALID_EMAIL_REGEX}, 
                           uniqueness: {case_sensitive: false}
  has_secure_password
  validates :password,  presence: true, length: {minimum: 1}, allow_nil: true

  private
  # makes all emails for User lowercase 
  def downcase_email
    self.email = email.downcase unless self.email.nil? 
  end
end
