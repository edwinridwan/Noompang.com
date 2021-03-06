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

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
