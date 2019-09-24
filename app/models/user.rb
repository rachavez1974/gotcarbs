class User < ApplicationRecord
  has_many :carts, dependent: :destroy
  has_many :addresses
  has_many :orders
  accepts_nested_attributes_for :addresses

  attr_accessor :remember_token
  before_save :downcase_email

  validates_associated :addresses
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

  def self.find_by_id_or_name(key)
    User.find_by(:id => key) || User.find_by(:first_name => key)
  end

  def full_name
    "#{self.first_name} #{self.last_name}"
  end

  # Returns the hash digest of the given string.
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # Returns a random token.
  def User.new_token
    SecureRandom.urlsafe_base64
  end

  def remember
    self.remember_token = User.new_token
    self.update_attribute(:remember_digest, User.digest(remember_token))
  end

  #Forgets a user.
  def forget
    update_attribute(:remember_digest, nil)
  end

  # Returns true if the given token matches the digest.
  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  def self.create_from_oauth(oauth_hash)
    #save user withouth validations
    user = User.new(first_name: oauth_hash["name"].split[0], email: oauth_hash["email"], password: User.new_token)
    if user.save(:validate => false)
      User.last
    end
  end

  def self.create_by_admin(params)
    params[:email] = "#{params[:first_name]}#{rand 0..10000000}@gotcarbs.org"
    params[:password] = User.new_token
      user = User.create(params)
      if user.save
        User.last
      end
  end

  private
  # makes all emails for User lowercase 
  def downcase_email
    self.email = email.downcase unless self.email.nil? 
  end
end
