# == Schema Information
#
# Table name: users
#
#  id                 :integer         not null, primary key
#  email              :string(255)     not null
#  password_digest    :string(255)     not null
#  first_name         :string(255)
#  last_name          :string(255)
#  date_of_birth      :date
#  location           :string(255)
#  mobile_number      :string(255)
#  remember_token     :string(255)
#  admin              :boolean         default(FALSE)
#  created_at         :datetime        not null
#  updated_at         :datetime        not null
#  image_url          :string(255)
#  last_read          :datetime
#  sign_in_count      :integer         default(0)
#  current_sign_in_at :datetime
#  last_sign_in_at    :datetime
#  current_sign_in_ip :string(255)
#  last_sign_in_ip    :string(255)
#  sex                :string(255)
#  locale             :string(255)
#  timezone           :string(255)
#  provider           :string(255)
#  uid                :string(255)
#  balance            :decimal(4, 2)   default(0.0)
#  total_votes        :integer         default(0)
#  total_score        :integer         default(0)
#
# Indexes
#
#  index_users_on_remember_token  (remember_token)
#  index_users_on_email           (email) UNIQUE
#

class User < ActiveRecord::Base
  
  include StringHelper

  devise :omniauthable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessible :email, :first_name, :last_name, 
                  :password, :password_confirmation, :date_of_birth,
                  :location, :mobile_number, :image_url, :last_read,
                  :provider, :uid, :timezone, :locale, :sex,
                  :admin #for populating database, to be removed for production!

  has_secure_password

  has_many :rides # to retrieve user's rides
  has_many :ride_requests, :dependent => :destroy
  has_many :notifications, :foreign_key => :target_id, :dependent => :destroy

  # Ensure email is all lower-case before it gets saved to the database
  before_save { |user| user.email = email.downcase }
  # Create random remember token for remembering this user upon signin
  before_save :create_remember_token

  # Validations
  #validates :first_name,  presence: true, length: { maximum: 50 }
  #validates :last_name,  presence: true, length: { maximum: 50 }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i  
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true
  validate  :check_image_url
  validates :balance, :numericality => { :greater_than_or_equal_to => 0.00 }

  # FACEBOOK AUTHENTICATION, similar methods to be defined for Twitter etc
  def self.find_for_facebook_oauth(access_token, signed_in_resource=nil)
    data = access_token.extra.raw_info
    if user = User.where(:email => data.email).first
      User.update_all ['image_url = ?', access_token.info.image], ['id = ?', user.id] 
      User.update_all ['location = ?', access_token.info.location], ['id = ?', user.id]
      # timezone
      if access_token.fetch('extra', {}).fetch('raw_info', {})['timezone']
        utc_offset_in_hours = (access_token.fetch('extra', {}).fetch('raw_info', {})['timezone']).to_i 
        timezone = (ActiveSupport::TimeZone[utc_offset_in_hours]).name
      else
        timezone = nil
      end
      #User.update_all ['timezone = ?', timezone], ['id = ?', user.id]
      user
    else 
      # Create a user with a stub password. 
      password = Devise.friendly_token[0,20]
      # birthday
      if access_token.fetch('extra', {}).fetch('raw_info', {})['birthday']
        d_o_b = Date.strptime(access_token.fetch('extra', {}).fetch('raw_info', {})['birthday'],'%m/%d/%Y')
      else
        d_o_b = nil
      end
      # timezone
      if access_token.fetch('extra', {}).fetch('raw_info', {})['timezone']
        utc_offset_in_hours = (access_token.fetch('extra', {}).fetch('raw_info', {})['timezone']).to_i 
        timezone = (ActiveSupport::TimeZone[utc_offset_in_hours]).name
      else
        timezone = nil
      end
      
      User.create!(:email => data.email, 
                   :password => password, :password_confirmation => password,
                   :image_url => access_token.info.image,
                   :location => access_token.info.location,
                   :first_name => access_token.info.first_name,
                   :last_name => access_token.info.last_name,
                   :date_of_birth => d_o_b,
                   :provider => access_token.provider,
                   :uid => access_token.uid,
                   :mobile_number => access_token.info.phone,
                   :timezone => timezone,
                   :locale => access_token.fetch('extra', {}).fetch('raw_info', {})['locale'],
                   :sex => access_token.fetch('extra', {}).fetch('raw_info',{})['gender'] )
    end
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"]
      end
    end
  end

  private

    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end

    def check_image_url
      if !image_url.blank? && !uri?(image_url)
        errors.add(:image_url)
      end
    end

end
