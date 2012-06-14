# == Schema Information
#
# Table name: users
#
#  id              :integer         not null, primary key
#  email           :string(255)     not null
#  password_digest :string(255)     not null
#  first_name      :string(255)
#  last_name       :string(255)
#  date_of_birth   :date
#  location        :string(255)
#  mobile_number   :string(255)
#  remember_token  :string(255)
#  admin           :boolean         default(FALSE)
#  created_at      :datetime        not null
#  updated_at      :datetime        not null
#
# Indexes
#
#  index_users_on_remember_token  (remember_token)
#  index_users_on_email           (email)
#

class User < ActiveRecord::Base
  attr_accessible :email, :first_name, :last_name, 
                  :password, :password_confirmation, :date_of_birth,
                  :location, :mobile_number
  has_secure_password
  has_many :rides # to retrieve user's rides
  has_many :ride_requests, :dependent => :destroy

  # Ensure email is all lower-case before it gets saved to the database
  before_save { |user| user.email = email.downcase }
  # Create random remember token for remembering this user upon signin
  before_save :create_remember_token

  # Validations
  validates :first_name,  presence: true, length: { maximum: 50 }
  validates :last_name,  presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i  
  validates :email, presence:true, format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true


  private

    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end
end
